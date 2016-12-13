function [tempBinaryImage, clusterData, detectedROI] = CaImGetROIs(filename,estNeuronRadius, cutoff)
%CaImGetROIs.m
%   Take as input a .avi, .tif file or 3d array and get out the individual 
%   ROIs that a simple algorithm has identified.
%   1) Performs an adaptive Wiener filter on each frame of the image to
%       reduce noise
%   2) Calculates a spatial average maximum cross-correlation across time 
%       at each pixel (maximum crosss-correlation with small collection of
%       neighboring pixels)
%   3) Performs a statistical test on these cross-correlations to
%       find pixels with significant spatiotemporal correlations with itself
%       and it's neighbors to create a binary image
%   4) Performs morphological closing to fill in any gaps for each of the
%       individual ROIs and opening to remove very small ROIs
%   5) Hierarchical clustering to form ROIs.
%
% INPUT: filename - .avi or .tif filename as a string, or a 3d array
%        estNeuronRadius - radius of ROI in pixels (defaults to 3)
%        cutoff - threshold on dissimilarity to define breaking point for
%        hierarchical clustering (default to .5) [could be a vector of
%        values for making ROC curves]
% OUTPUT: finalBinaryImage - binary image of identified signal pixels
%         clusterData - results of hierarchical clustering
%         detectedROI - cell of structures defining ROI for input cutoff
%         values
%         figures of intermediate steps
% 
%Created: 2016/11/08
% Byron Price
%Updated: 2016/12/4
%  By: Byron Price & Janis Intoy

% Future steps:
%  1) think about the noise inherent in actual calcium imaging videos
%      e.g. if the noise is correlated in time across more than 1 lag, then
%      many of the noisy pixels will be picked out as having significant
%      autocorrelations
%  2) reducing the number of decisions made in the algorithm (thresholds on
%       noise, requiring an approximate neuron size, defining distance cutoffs,
%       deciding upon a shape for opening and closing
%  3) performance optimization - improving time and memory usage of this
%       code. One obvious place for improvement is in the cross correlation
%       computation itself (one could do this in the frequency domain
%       instead). Another is that this currently repeats many
%       cross-correlation computations in the summed cross correlation
%       section and in the final part before linkage clustering.

if nargin < 2
    estNeuronRadius = 3;
    cutoff = .5;
elseif nargin < 3
    cutoff = .5;
end

estNeuronRadius = round(estNeuronRadius);

%% read input
if ischar(filename)
    [~, ~, ext] = fileparts(filename);
    switch ext
        case '.avi'
            vidObj = VideoReader(filename);
            numFrames = vidObj.FrameRate*vidObj.Duration;
            fullVideo = zeros(vidObj.Height,vidObj.Width,numFrames);
            
            count = 1;
            while hasFrame(vidObj)
                temp = readFrame(vidObj);
                fullVideo(:,:,count) = mean(double(temp),3);
                count = count+1;
            end
            fullVideo = fullVideo(60:470,230:640,:);
        case '.tif'
            fullVideo = readTifStack(filename);
            numFrames = size(fullVideo, 3);
    end
else % data input is already 3d array
    fullVideo = filename;
    numFrames = size(fullVideo, 3);
end

width = size(fullVideo,1);
height = size(fullVideo,2);

%% denoise with wiener filter
fltVideo = zeros(size(fullVideo));
for ii=1:numFrames
    temp = fullVideo(:,:,ii);
    fltVideo(:,:,ii) = wiener2(temp,[estNeuronRadius,estNeuronRadius]);
end

%% look for signal vs. noise pixels using summed cross-correlation
fprintf('%s: getting summed cross correlations\n', datestr(now));
summedCrossCorr = zeros(width,height);
divisor = zeros(width,height);
maxlag = 5;
for ii=1:width
    for jj=1:height
        rowVec = max(1, ii-estNeuronRadius):min(width, ii+estNeuronRadius);
        colVec = max(1, jj-estNeuronRadius):min(height, jj+estNeuronRadius);
        for kk=rowVec
            for ll=colVec
                temp = myXCORR(squeeze(fltVideo(ii,jj,:)),squeeze(fltVideo(kk,ll,:)),maxlag);
                summedCrossCorr(ii,jj) = summedCrossCorr(ii,jj)+...
                    max(temp(temp~=1));
                divisor(ii,jj) = divisor(ii, jj)+1;
            end
        end
    end
end
summedCrossCorr = summedCrossCorr./divisor;
figure();imagesc(summedCrossCorr);title('Spatial Average Maximum Cross-Correlation Image');

temp = summedCrossCorr(:);
GMModel = fitgmdist(temp,2);
mu = GMModel.mu;Sigma = GMModel.Sigma;
[~,minInd] = min(mu);
 
threshold = mu(minInd)+3*sqrt(Sigma(minInd));
binaryCrossCorr  = summedCrossCorr > threshold;

forHistogram = summedCrossCorr(:);
forHistogram = forHistogram(forHistogram ~= 0);
figure();histogram(forHistogram);hold on;
[N,~] = histcounts(forHistogram);
plot(ones(100,1).*threshold,linspace(0,max(N),100),'r','LineWidth',2);
xlabel('Spatial Average Maximum Cross-Correlation');ylabel('Count');
title('Histogram of Maximum Cross-Correlation Coefficients');
legend('Histogram','Threshold');

%% morphological opening and closing
se = strel('disk',round(estNeuronRadius/4));
se2 = strel('disk',round(estNeuronRadius));
tempBinaryImage = imclose(imopen(binaryCrossCorr,se),se2);

figure();imagesc(tempBinaryImage);colormap('bone');
title('Binary Mask for ROI Detection');

%% remove noisy background
maskedVideo = zeros(size(fltVideo));
for ii=1:numFrames 
    maskedVideo(:,:,ii) = fltVideo(:,:,ii).*tempBinaryImage;
end

%% computing cross correlations between nearby signal pixels
fprintf('%s: getting dissimilarity matrix\n', datestr(now));

% Only use pixels deemed signal - these are the pixels we want to classify
% into ROI.
usePixels = find(tempBinaryImage);

% Store cross correlation values in a format that is similar to the output
% of the built-in function pdist. The indices of the pairs of pixels for
% this format come from the lower triangular half of a square matrix. The
% following lines get the indices of signal-pixel pairs and their
% corresponding indices in the original matrix.
idx = find(tril(true(length(usePixels)), -1));
% row and columns of lower triangular matrix
[tempr, tempc] = ind2sub([length(usePixels), length(usePixels)], idx);
indexArray = [tempr, tempc];
usePixelArray = usePixels(indexArray);

% Get the row and column position of signal pixels in the original matrix
% and compute the distances between pairs of pixels.
col = ceil(usePixelArray / width);
row = usePixelArray - width * (col - 1);
pixelDist = sqrt((col(:, 1) - col(:, 2)).^2 + (row(:, 1) - row(:, 2)).^2);

% Get the maximum cross-correlations between pairs of pixels that are
% within 3 estimated-radii of each other. This is a pretty liberal
% threshold on distance and is a free parameter. If the distance between
% pixels is above this threshold define the cross correlation to be 0.
xcorrArray = zeros(length(indexArray), 1);
for ii = 1:length(xcorrArray)
    if pixelDist(ii) > 3*estNeuronRadius
        continue; 
    end
    
    idxr = row(ii, 1);
    idxc = col(ii, 1);
    jdxr = row(ii, 2);
    jdxc = col(ii, 2);
    
    xcorrArray(ii) = max(myXCORR(squeeze(fltVideo(idxr, idxc, :)),...
        squeeze(fltVideo(jdxr, jdxc, :)), maxlag));
end

% Convert the cross-correlation coefficients into "dissimilarity", which is
% more like a proximity measure. Pixels with a stronger relationship will
% have a dissimilarity value nearer to 0 as if they are closer together.
dissimilarity = 1 - xcorrArray;

% Run linkage - this step repeatedly pairs two objects with the smallest
% dissimilarity values to form hierarchical clusters. The 'complete' option
% defines the dissimilarity between two clusters to be the maximum
% dissimilarity between any two members of the clusters.
Z = linkage(dissimilarity', 'complete');
figure(); dendrogram(Z, 0, 'colorthreshold', .5); % threshold for plotting only

% cutoff defines the dissimilarity value at which to break clusters. For
% the purposes of generating an ROC curve it accepts a vector of values.
% The output of "cluster" is a vector of integers defining the class for
% each pixel of usePixels.
T = nan(length(usePixels), length(cutoff));
for i = 1:length(cutoff)
    t = cluster(Z, 'cutoff', cutoff(i), 'criterion', 'distance');
    T(:, i) = t;
end

% save relevant information to a structure to output
clusterData = struct('signalPixels', usePixels, ...
    'cutoffs', cutoff,...
    'class', T, ...
    'dissimilarity', dissimilarity);

% Organize the cluster output into ROI. Eliminate any clusters that have fewer
% than 2*estNeuronRadius pixels (another somewhat arbitrary threshold).
% The field 'trueROI' is meant to be filled in at a later time if comparing
% to simulated data.
detectedROI = cell(length(cutoff), 1);
for t = 1:length(cutoff)
    tempROI = struct('indices', [], 'trueROI', []);
    cnt = 1;
    for i = 1:max(clusterData.class(:, t))
        idx = clusterData.class(:, t) == i; % indices of pixels in this cluster
        if sum(idx) > 2*estNeuronRadius % threshold the size of an ROI
            sIdx = clusterData.signalPixels(idx);
            tempROI(cnt).indices = sIdx;
            cnt = cnt + 1;
        end
    end
    detectedROI{t} = tempROI;
end
end

function [crossCorr] = myXCORR(Signal1,Signal2,numLags)
%myXCORR.m
% computes cross-correlation coefficients for lags up to numLags
% author: Byron Price

autoCorr = zeros(2,1);

Signal1 = Signal1-mean(Signal1);
Signal2 = Signal2-mean(Signal2);

autoCorr(1) = sum(Signal1.*Signal1);
autoCorr(2) = sum(Signal2.*Signal2);
crossCorr = zeros(numLags+1,1);

for ii=0:numLags
    crossCorr(ii+1) = sum(Signal1(ii+1:end).*Signal2(1:end-ii));
end

crossCorr = crossCorr./sqrt(autoCorr(1)*autoCorr(2));
end
