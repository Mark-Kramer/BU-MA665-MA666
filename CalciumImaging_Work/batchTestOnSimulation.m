% batchTest script
% aggregate data from individual test trials output by sccRunTests.m (for
% example on the shared computing cluster)
% plots ROC curve, ROI hit rate, and ratio of # detected / # true ROI
% author: Janis Intoy
% date: November 29, 2016
clear all;

% path to output mat files of sccRunTests.m
ptToData = 'results_1858698_hierarchical'; 
dr = dir(fullfile(ptToData, '*.mat'));

% parameters of the test run
snrs = [3, 5, 10, 30, 50];
nROIs = 1:7;
noisePW = [0, 2];

cutoff = .1:.1:1; % cutoffs for hierarchical clustering
%cutoff = [1e-2,1e-1,1e0,1e1,1e2]; % tolerances for kmeans algorithm
maxTrials = 50;


%% open all files and reorganize data 
nTrials = zeros(length(nROIs), length(snrs), length(noisePW), length(cutoff));

hitSignal = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);
faSignal = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);
hitROI = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);
nDetectedPerTrueROI = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);

nSignal = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);
nNoise = nan(length(nROIs), length(snrs), length(noisePW), length(cutoff), maxTrials);
for i = 1:length(dr)
    temp = load(fullfile(ptToData, dr(i).name), 'params', 'out', 'truthMap');
    
    snr = find(snrs == temp.params.snr);
    pw = find(noisePW == temp.params.noisePW);
    nROI = find(nROIs == temp.params.nROI);
    
    for j = 1:length(cutoff)
        nt = nTrials(nROI, snr, pw, j) + 1;
        nTrials(nROI, snr, pw, j) = nt;
        
        nSignal(nROI, snr, pw, j, nt) = sum(temp.truthMap(:));
        nNoise(nROI, snr, pw, j, nt) = sum(~temp.truthMap(:));
        
        hitSignal(nROI, snr, pw, j, nt) = temp.out{j}.hitSignal;
        faSignal(nROI, snr, pw, j, nt) = temp.out{j}.faSignal;
        
        nDetectedPerTrueROI(nROI, snr, pw, j, nt) = temp.out{j}.nDetectedPerTrueROI;
        hitROI(nROI, snr, pw, j, nt) = temp.out{j}.hitROI;
            
    end
end

%% pixels that get through clustering
% get hit and false alarm rates to make a ROC curve
hits = nan(length(cutoff), length(snrs), length(noisePW));
fas = nan(length(cutoff), length(snrs), length(noisePW));
for s = 1:length(snrs)
    for p = 1:length(noisePW)
        hit = squeeze(hitSignal(:, s, p, :, :));
        fa = squeeze(faSignal(:, s, p, :, :));
        
        nS = squeeze(nSignal(:, s, p, :, :));
        nN = squeeze(nSignal(:, s, p, :, :));
        
        tS = squeeze(nansum(nansum(nS, 1), 3));
        tN = squeeze(nansum(nansum(nN, 1), 3));
        
        hits(:, s, p) = squeeze(nansum(nansum(hit .* nS, 1), 3)) ./ tS;
        fas(:, s, p) = squeeze(nansum(nansum(fa .* nN, 1), 3)) ./ tS;
    end
end

fh = 0;

% plot the ROC curve for detecting signal pixels that get through
% clustering
for p = 1:size(hits, 3)
    fh = fh + 1;
    figure(fh); clf;
    set(gcf, 'Color', 'w');
    hold on;
    set(gca, 'FontWeight', 'bold', 'FontSize', 14);
    title(sprintf('noise spectrum 1/f^%i', noisePW(p)),...
        'FontSize', 20, 'FontWeight', 'bold');
    for s = 1:size(hits, 2)
        plot(fas(:, s, p), hits(:, s, p), '.-', 'markersize', 20);
    end
    xlabel('False Alarm Rate', 'FontSize', 16, 'FontWeight', 'bold');
    ylabel('Hit Rate', 'FontSize', 16, 'FontWeight', 'bold');
    
    lg = legend(cellfun(@(x) ['SNR=', num2str(x)], num2cell(snrs), 'UniformOutput', false),...
        'Location', 'southeast', 'FontSize', 14, 'FontWeight', 'bold');
    xlim([0, .3]);
    ylim([0, 1]);
end

%% number detected ROI with matching true ROI
ratioDetected = nan(length(cutoff), length(snrs), length(noisePW));
for s = 1:length(snrs)
    for p = 1:length(noisePW)
        temp = squeeze(nDetectedPerTrueROI(:, s, p, :, :));
        %temp = bsxfun(@times, nROIs'/sum(nROIs), temp); % weigh by nROI
        
        temp = nanmean(nanmean(temp, 1), 3);
        ratioDetected(:, s, p) = squeeze(temp);
    end
end

for p = 1:size(hits, 3)
    fh = fh + 1;
    figure(fh); clf;
    set(gcf, 'Color', 'w');
    hold on;
    title(sprintf('noise spectrum 1/f^%i', noisePW(p)),...
        'FontSize', 20, 'FontWeight', 'bold');
    for s = 1:size(ratioDetected, 2)
        plot(cutoff, squeeze(ratioDetected(:, s, p)), '.-', 'markersize', 20);
    end
    xlabel('cutoff', 'FontSize', 16, 'FontWeight', 'bold');
    ylabel('ratio of detected to true ROI', 'FontSize', 16, 'FontWeight', 'bold');
    
    lg = legend(cellfun(@(x) ['SNR=', num2str(x)], num2cell(snrs), 'UniformOutput', false),...
        'Location', 'southeast', 'FontSize', 14, 'FontWeight', 'bold');
    ylim([0, 1.4]);
    lineThrough(1, 'k', gca, '--');
end

%% hit rate on ROIs
hitROI2 = nan(length(cutoff), length(snrs), length(noisePW));
for s = 1:length(snrs)
    for p = 1:length(noisePW)
        temp = squeeze(hitROI(:, s, p, :, :));
        %temp = bsxfun(@times, nROIs'/sum(nROIs), temp); % weigh by nROI
        
        temp = nanmean(nanmean(temp, 1), 3);
        hitROI2(:, s, p) = squeeze(temp);
    end
end

for p = 1:size(hits, 3)
    fh = fh + 1;
    figure(fh); clf;
    set(gcf, 'Color', 'w');
    hold on;
    
    title(sprintf('noise spectrum 1/f^%i', noisePW(p)),...
        'FontSize', 20, 'FontWeight', 'bold');
    for s = 1:size(ratioDetected, 2)
        plot(cutoff, squeeze(hitROI2(:, s, p)), '.-', 'markersize', 20);
    end
    xlabel('cutoff', 'FontSize', 16, 'FontWeight', 'bold');
    ylabel('ROI hit rate', 'FontSize', 16, 'FontWeight', 'bold');
    
    lg = legend(cellfun(@(x) ['SNR=', num2str(x)], num2cell(snrs), 'UniformOutput', false),...
        'Location', 'southeast', 'FontSize', 14, 'FontWeight', 'bold');
end