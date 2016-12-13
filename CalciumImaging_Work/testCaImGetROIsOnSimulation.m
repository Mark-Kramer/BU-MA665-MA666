function [out, truthMap, ROI] = testCaImGetROIsOnSimulation(params)
% [out, truthMap, ROI] = testCaImGetROIsOnSimulation(params)
% Simulates a calcium imaging signal, runs a segmentation algorithm on it,
% and returns statistics which show the algorithm's performance.
% 
% Inputs:
%   params - [optional] structure defining spatial image size (sz), signal
%   duration (dur), number of ROI (nROI), signal to noise ratio (snr),
%   noise spectrum type (noisePW), cutoff or tolerances (cutoff) for segmentation
%   algorithms and name of file to save simulation to
%   (svMovie) for the simulation. Defaults are used otherwise.
% Outputs:
%   out - struct with hit and FA rates, d-prime values,... for each cutoff
%   value
%   truthMap - binary array of true signal pixel locations
%   ROI - ROI structure of simulated data
% author: Janis Intoy
% date: November 9, 2016
% modified: Novemeber 10, 2016 - added hit and false alarm rate calcs

%% parameters
if ~exist('params', 'var')
    sz = 30; % sz x sz image
    dur = 10; % seconds sampled at 30Hz
    nROI = 5; % number of cells
    snr = 10; % signal to noise ratio
    noisePW = 1; % noise magnitude spectrum (1/freq^noisePW) (0 = white)
    svMovie = ''; % filename to save movie as .tif
    cutoff = .5; % cutoff for hierarchical clustering
    estNeuronRadius = 5;
    
else
    sz = params.size;
    dur = params.duration;
    nROI = params.nROI;
    snr = params.snr;
    noisePW = params.noisePW;
    svMovie = params.saveMovie;
    estNeuronRadius = params.estNeuronRadius;
    cutoff = params.cutoff;
end


%% simulate data
[ROI, full] = simulateCalcImg(sz, dur, nROI, snr, noisePW, svMovie);

%% automatic segmenation algorithm
% choose a segmentation algorithm to run
[finalBinaryImage,clusterData, detectedROI] = CaImGetROIs(full, estNeuronRadius, cutoff);

% To Run KMeans Algorithm
%cutoff = [1e-2,1e-1,1e0,1e1,1e2];
%[detectedROI, finalBinaryImage] = kmeans_CaImGetROIs(full,estNeuronRadius,nROI);

%% truth map - >0 for signal pixels, 0 for noise only
truthMap = zeros(sz);
for i = 1:nROI
    truthMap(ROI(i).indices) = i; % if overlap the later index dominates
end

%% plot: compare Components and ROI
out = cell(size(detectedROI));
for t = 1:length(detectedROI) % length depends on number of cutoffs given
    detectedMap = zeros(sz);
    
    figure(); hold on;
    imagesc(truthMap);
    colormap jet;
    
    for j = 1:length(detectedROI{t})
        % draw the outline of the detected ROI
        sIdx = detectedROI{t}(j).indices;
        [r, c] = ind2sub([sz, sz], sIdx);
        if ~isempty(r)
            K = boundary(c, r);
            plot(c(K), r(K), 'k', 'linewidth', 2);
        end
        
        
        % match with a true ROI
        truth = truthMap(sIdx);
        
        detectedROI{t}(j).trueROI = mode(truth); % will be zero if no match
        detectedROI{t}(j).indices = sIdx;
        detectedMap(sIdx) = 1;
    end
    % plotTrueROIOverlay(ROI);
    axis image;
    xlim([1, sz]); ylim([1, sz]);
    title(sprintf('detected overlaid on true: cutoff = %1.3f', cutoff(t)));
    set(gca, 'YDir', 'reverse');
    
    
    %% test pixels that made it through noise removal process
    hitPixels = sum(truthMap(:) > 0 & finalBinaryImage(:)) / sum(truthMap(:) > 0);
    faPixels = sum(truthMap(:) == 0 & finalBinaryImage(:)) / sum(truthMap(:) == 0);
    dprimePixels = norminv(hitPixels, 0, 1) - norminv(faPixels, 0, 1);
    
    %% test pixels that made it through clustering
    hitSignal = sum(truthMap(:) > 0 & detectedMap(:)) / sum(truthMap(:) > 0);
    faSignal = sum(truthMap(:) == 0 & detectedMap(:)) / sum(truthMap(:) == 0);
    dprimeSignal = norminv(hitSignal, 0, 1) - norminv(faSignal, 0, 1);
    
    %% ROI analysis
    % ignore detected ROI that didn't match, they'll be evident in the
    % false alarm rates of the above analysis
    foundROIs = [detectedROI{t}.trueROI];
    actualNROI = length(unique(truthMap(:))) - any(truthMap(:) == 0);
    nDetectedPerTrue = sum(foundROIs > 0) / actualNROI;
    
    nDetected = length(unique(foundROIs)) - any(foundROIs == 0);
    hitROI = nDetected / actualNROI;
    
    %% save output variables
    tout = struct('hitPixels', hitPixels,...
        'faPixels', faPixels,...
        'dprimePixels', dprimePixels,...
        'hitSignal', hitSignal,...
        'faSignal', faSignal,...
        'dprimeSignal', dprimeSignal,...
        'nDetectedPerTrueROI', nDetectedPerTrue,...
        'hitROI', hitROI, ...
        'finalBinaryImage', finalBinaryImage,...
        'detectedMap', detectedMap);
    out{t} = tout;
end


end