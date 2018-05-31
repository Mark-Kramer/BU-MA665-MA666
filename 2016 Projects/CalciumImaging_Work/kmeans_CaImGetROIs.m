function [detectedROI,finalBinaryImage] = kmeans_CaImGetROIs(filename,estNeuronRadius,maxNeurons)
%kmeans_CaImGetROIs.m
%   Take as input a .avi or .tif file and get out the individual ROIs that a simple
%    algorithm has identified.
%   1) Performs an adaptive Wiener filter on each frame of the image to
%       reduce noise
%   2) Calculates a spatial average maximum cross-correlation across time 
%       at each pixel (maximum crosss-correlation with small collection of
%       neighboring pixels)
%   3) Thresholds the crosss-correlation coefficients based on a simple
%       non-parametric test to find pixels that might belong to cells.
%   4) Creates a binary image of those potential pixels
%   5) Performs morphological opening to remove very small ROIs
%   6) Runs k-means clustering to merge or separate tentative ROIs
%    7) Does not yet but could ... subtract out the regions just determined
%    to be ROIs and iterate the algorithm again to see if anything was
%    misssed the first time
%
% INPUT: filename - .avi or .tif filename as a string, or matlab array
%          (width-by-height-by-number of frames)
%        estNeuronRadius - radius of ROI in pixels (defaults to 5)
%        maxNeurons - maximum number of neurons in field of view (defaults
%         to 20) 
% OUTPUT: detectedROI - a struct array containing pixel indeces for the
%          identified ROIs across various values of a parameter called
%          tolerance
%         finalBinaryImage - a binary image that initializes the search for
%          ROIs, it's effectively: potential signal = 1 and noise = 0
% 
%Created: 2016/11/18
% Byron Price
%Updated: 2016/12/05
%  By: Byron Price

% Future steps:
%  1) think about the noise inherent in actual calcium imaging videos
%      e.g. if the noise is correlated in time across more than 1 lag, then
%      many of the noisy pixels will be picked out as having significant
%      auto/cross-correlations
%  2) remove non-stationary background in time and space ... in many
%      videos, especially single-photon ones, the noise appears to be highly
%      correlated with the signal, which would break this algorithm
%  3) try different initializations to find signal pixels ... different
%      types of projection images (standard deviation, maximum brightness,
%      maximum auto-correlation, maximum partial auto-correlation, or
%      combinations thereof) ... you could calculate a weighted sum of all
%      those and find the metric that provides the greatest separation
%      between signal pixels and noise pixels
%  4) figure out how to punish the distance metric in the k-means algorithm
%      so that two pixels significantly separated in Euclidean space do not form
%      part of the same cell and so that each ROI is one connected component 
%      ... right now the distance metric is a correlation metric and the 
%      euclidean distance between pixels is ignored
%  http://www.nature.com/articles/srep08143  for partial cross-correlation

if nargin < 2
    estNeuronRadius = 5;
    maxNeurons = 20;
elseif nargin < 3
    maxNeurons = 20;
end

estNeuronRadius = round(estNeuronRadius);
estNeuronArea = pi*estNeuronRadius*estNeuronRadius;

% check filename for its data type and load the video accordingly
if ischar(filename) % data input is .avi or .tif or matlab array
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
            %fullVideo = fullVideo(60:470,230:640,:);
        case '.tif'
            fullVideo = double(readTifStack(filename));
            numFrames = size(fullVideo, 3);
    end
else % data input is already 3d array
    fullVideo = filename;
    numFrames = size(fullVideo, 3);
end

minVal = min(min(min(fullVideo)));
maxVal = max(max(max(fullVideo)));
fullVideo = (fullVideo-minVal)./(maxVal-minVal);
% consider spatial downsample ... maybe temporal as well
% fullVideo = fullVideo(1:2:end,1:2:end,:);

% denoise each frame separately with Wiener filter and 
%  calculate a "maximum brightness composite image" 
width = size(fullVideo,1);
height = size(fullVideo,2);

maxBrightIm = zeros(width,height);
display('Filtering video...');
fltVideo = zeros(size(fullVideo));
for ii=1:numFrames
    temp = fullVideo(:,:,ii);
    fltVideo(:,:,ii) = wiener2(temp,[round(estNeuronRadius/2),round(estNeuronRadius/2)]);
    pixelValues = fltVideo(:,:,ii);threshold = quantile(pixelValues(:),0.99);
    maxBrightIm = maxBrightIm+(pixelValues>threshold);
end
maxBrightIm = maxBrightIm>2;
% figure();imagesc(maxBrightIm);

%implay(uint8(fltVideo));

% % maximum first-derivative projection
% maxFirstDeriv = zeros(width,height);
% sampleFreq = 30; %fps 
% for ii=1:width
%     for jj=1:height
%         temp = zeros(length(2:numFrames-1),1);
%         for kk=2:numFrames-1
%             temp(kk-1) = (fltVideo(ii,jj,kk+1)-fltVideo(ii,jj,kk-1)).*sampleFreq;
%         end
%         maxFirstDeriv(ii,jj) = max(temp);
%     end
% end
% figure();imagesc(maxFirstDeriv);

display('Calculating cross-correlations...');
% initialize search for ROIs by taking cross-correlations, 
%  we look for pixels with significant auto-correlations and 
%  cross-correlations with neighboring pixels
%  this is very slow and does not work well on real data, consider
%  initializing the search with some kind of maximum brightness projection,
%  a standard deviation projection, the above maximum first derivative
%  projection, or a maximum partial auto- or cross- correlation image

% This is a spatial-average cross-correlation
% parCorrImage = zeros(width,height);
summedCrossCorr = zeros(width,height);
divisor = zeros(width,height);
maxlag = 5;
for ii=1:width
    for jj=1:height
        % take cross-correlations in a small window around each pixel in
        %  the image
%         temp = parcorr(squeeze(fltVideo(ii,jj,:)),maxlag);
%         parCorrImage(ii,jj) = max(abs(temp(2:end)));
        rowVec = max(1, ii-estNeuronRadius):min(width, ii+estNeuronRadius);
        colVec = max(1, jj-estNeuronRadius):min(height, jj+estNeuronRadius);
        for kk=rowVec
            for ll=colVec
                temp = myXCORR(squeeze(fltVideo(ii,jj,:)),squeeze(fltVideo(kk,ll,:)),maxlag);
                summedCrossCorr(ii,jj) = summedCrossCorr(ii,jj)+...
                    max(temp(temp~=1));
                divisor(ii,jj) = divisor(ii,jj)+1;
            end
        end
    end
end
% figure();imagesc(parCorrImage);

summedCrossCorr = summedCrossCorr./divisor;
% figure();imagesc(summedCrossCorr);title('Spatial Average Maximum Cross-Correlation Image');

% % for thresholding the cross-correlation coefficients
% works well on simulated data, poorly on real data, need to understand
% statistic of noise better
temp = summedCrossCorr(:);
GMModel = fitgmdist(temp,2); % fit a 2-component Gaussian mixture model for 
             % the set of cross-correlation coefficients ...
             % noisy pixels form a large Gaussian in the histogram  of
             % 'temp' at low correlation values
mu = GMModel.mu;Sigma = GMModel.Sigma;
[~,minInd] = min(mu);

% % thresholding creates a binary image, which shows pixels in the field
% %  of view that might belong to cells
threshold = mu(minInd)+3*sqrt(Sigma(minInd));
tempBinaryImage  = summedCrossCorr > threshold;

% add the maximum brightness composite image to the binary image (which
%  will probably add a few additional pixels to the thresholded 
%  summedCrossCorr image)
tempBinaryImage = tempBinaryImage+maxBrightIm;

display('Finding, merging, and/or separating components...');

% morphological opening to clear away things too small to be cells
tempBinaryImage = bwareaopen(tempBinaryImage,round(estNeuronArea/4));

% find the set of connected components ... all pixels with values greater than
%  0 in tempBinaryImage
finalBinaryImage = tempBinaryImage>0;
Components = bwconncomp(finalBinaryImage);
PixelIdxList = Components.PixelIdxList;
numComponents = Components.NumObjects;

allPixels = [];
for jj=1:numComponents
    allPixels = [allPixels;PixelIdxList{jj}];
end

% k-means clustering (really, x-means) to determine how many cells are
%  visible in the video and to which cell each pixel belongs
tempPixelIdxList = cell(maxNeurons,1);
bigSum = zeros(maxNeurons,1);
display('Performing k-means clustering...');
for kk=1:maxNeurons
    % create input matrix X to k-means algorithm
    [r,c] = ind2sub([width,height],allPixels);
    X = zeros(length(allPixels),numFrames);
    for ll=1:length(allPixels)
        X(ll,:) = squeeze(fltVideo(r(ll),c(ll),:))'-...
            mean(squeeze(fltVideo(r(ll),c(ll),:))');
    end
    % correlation is the metric, as pixels within the same cell should be
    %  highly correlated, need to figure out how to punish for pixels that
    %  are far away and punish for ROIs that are not connected into one
    %  component
    [idx,~,SUMD] = kmeans(X,kk,'Distance','correlation','Replicates',10);
    bigSum(kk) = sum(SUMD);
    tempPixelIdxList{kk} = idx;
end
difference = diff(-bigSum);

figure();plot(bigSum,'LineWidth',2);
% try to find the "elbow" of the bigSum vector ... plot bigSum to see that
%  it looks a bit like an AIC curve ... it's the sum of the distances
%  between every pixel and the centroid of the cell to which it belongs ...
%  the sum is very high at first, as pixels are incorrectly attached to a
%  distal centroid point, but the value decreases as k (the number of clusters)
%  increases ... the value effectively saturates at an elbow point on the
%  curve and we find that by specifying a tolerance in the difference
%  between adjacent summed distances
tolerance = [1e-2,1e-1,1e0,1e1,1e2];
detectedROI = cell(length(tolerance), 1);
for t=1:length(tolerance)
    minInd = find(difference<tolerance(t),1,'first');
    if isempty(minInd) == 1
        idealComponents = maxNeurons;
    else
        idealComponents = minInd;
    end
    idealIdx = tempPixelIdxList{idealComponents};

    tempROI = struct('indices', [], 'trueROI', []);
    cnt = 1;
    for ii = 1:idealComponents
        idx = idealIdx == ii; % indices of pixels in this cluster
        if sum(idx) > estNeuronArea/4 % threshold the size of an ROI
            sIdx = allPixels(idx);
            tempROI(cnt).indices = sIdx;
            cnt = cnt + 1;
        end
    end
    detectedROI{t} = tempROI;
    
%     figure();hold on;
%     for ii=1:idealComponents
%         pixels = allPixels(idealIdx==ii);
%         [r,c] = ind2sub([width,height],pixels);
%         plot(r,c,'.','MarkerSize',10);
%     end
%     set(gca,'YDir','reverse');title(sprintf('%d Identified Cells',idealComponents));
end

end

function [crossCorr] = myXCORR(Signal1,Signal2,numLags)
%myXCORR.m
% calculate cross-correlation between two signals with no slow MATLAB fluff
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
