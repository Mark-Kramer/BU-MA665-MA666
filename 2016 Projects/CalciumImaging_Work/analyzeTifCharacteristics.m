% Janis's script to analyze statistics of actual calcium image data
% this is written more modularly than sequentially so it may not run all
% the way through. But different cells explore different things like the
% spectral properties of calcium imaging data or what a spectrally whitened
% video would look like

addpath(genpath('ca_source_extraction-master'));

% VideoFile = 'demoMovie.tif';
VideoFile = fullfile('Emily_Data', 'Raw_WWY_080116_3_089.tif');
%VideoFile = fullfile('C:', 'Users', 'jintoy', 'Desktop', 'SLEEP01.tif');
%VideoFile = 'example_n3_2.tif';

Y = readTifStack(VideoFile);
Y = double(Y);
if rem(size(Y, 3), 2) == 1
    Y = Y(:, :, 1:end-1); 
end
if rem(size(Y, 1), 2) == 1
    Y = Y(1:end-1, :, :); 
end
if rem(size(Y, 1), 2) == 1
    Y = Y(:, 1:end-1, :); 
end

snr = max(Y(:)) / std(Y(:));

[sz1, sz2, sz3] = size(Y);

%% run Emily's data through our algorithm
% Emily's data shifts around frame 200, I'll cut if off before then
%Ycut = Y(1:100, 1:100, 1:175);
%sYcut = Y;
Ycut = Y(250:350, 150:250, :);
Ycut = Ycut - min(Ycut(:));
Ycut = Ycut / max(Ycut(:));
tic; 
% [finalBinaryImage, clusterData, detectedROIs] = ...
%     CaImGetROIs(Ycut, 10, .9);
[detectedROIs, finalBinaryImage] = kmeans_ForJanis(Ycut,10,5);
toc;
%%
figure(312); clf; hold on;
imagesc(var(Ycut, [], 3));
axis image;
for i = 1:length(detectedROIs{1})
    sIdx = detectedROIs{1}(i).indices;
        [r, c] = ind2sub([size(Ycut, 1), size(Ycut, 2)], sIdx);
        if ~isempty(r)
            K = boundary(c, r);
            plot(c(K), r(K), 'k', 'linewidth', 2);
        end
end
set(gca, 'YDir', 'reverse');

%% play Y as a movie
m = Y;

figure(100); clf;
h = imagesc(m(:, :, 1));
cmax = max(m(:));
cmin = min(m(:));
caxis([cmin, cmax]);
axis image;
% xlim([1, 100]);
% ylim([1, 100]);s

for i = 1:size(m, 3)
    set(h, 'CData', m(:, :, i)); 
    caxis([cmin, cmax]);
    pause(.1);
end

%% max projection
m = Ycut;

maxProj = zeros(size(m, 1), size(m, 2));
for t = 1:size(m, 3)
    temp = m(:, :, t);
    q = quantile(temp(:), .99);
    maxProj = maxProj + (temp > q);
end
figure(101); clf;
imagesc(maxProj);
axis image;

figure(102); clf;
hist(maxProj(:), 50);

%% portion of Y that looks like only noise
m = Yw;
figure(31); clf; hold on;
% Emily Data
% plot(squeeze(Y(25, 275, :)));
% plot(squeeze(Y(434, 146, :)));
% Sleep 1
plot(squeeze(m(180, 145, :)));
plot(squeeze(m(180, 144, :)));

ns = squeeze(m(250, 199, :)); % temporal signal from a noise pixel
ss = squeeze(m(182, 226, :)); % temporal signal from a cell pixel

varAll = var(m(:));
vart1 = var(tocol(m(:, :, 1)));
vart200 = var(tocol(m(:, :, 200)));
varns = var(ns);
varss = var(ss);

fprintf('variance of full movie\t%1.3f\n', varAll);
fprintf('variance of 1st frame \t%1.3f\n', vart1);
fprintf('variance of end frame \t%1.3f\n', vart200);
fprintf('variance of ns  pixel\t%1.3f\n', varns);
fprintf('variance of ss  pixel\t%1.3f\n', varss);

%% histogram of variance of each pixel
varT = var(Y, [], 3);
figure(31); clf;
hist(varT(:), linspace(0, 2*10^5, 100));

%% analyze noise in frequency domain
f3 = fftshift(fftn(Y));
ps = 10*log10(abs(f3).^2);

% radial average over spatial dimensions
radPS = nan(size(f3, 1)/2, size(f3, 3)/2);
for i = 1:size(f3, 3)/2
    temp = RadialProfile(ps(:, :, i), size(f3, 1)/2);
    radPS(:, size(f3, 3)/2 - i + 1) = temp;
end
%% plot the radial power spectrum
figure(2); clf;
axes('Position', [.3 .3 .6 .6]);
pcolor(radPS');
xlabel('spatial frequency (idx)');
ylabel('temporal frequency (idx)');
shading interp;
colormap hot;
xlim([1, size(radPS, 1)]);
ylim([1, size(radPS, 2)]);

axes('Position', [.3 .05 .6 .1]);
plot(mean(radPS, 2));
xlim([1, size(radPS, 1)]);

axes('Position', [.05 .3 .1 .6]);
plot(mean(radPS, 1), 1:size(radPS, 2));
set(gca, 'XDir', 'reverse');
ylim([1, size(radPS, 2)]);

%% spectral whitening should emphasize edges in space and time
f3w = f3 ./ abs(f3);
Yw = real(ifftn(ifftshift(f3w)));

%% make a movie of Y and Yw side by side
figure(200); clf;
ax1 = subplot(1, 2, 1);
h1 = imagesc(Y(:, :, 1));
cmax1 = max(Y(:));
cmin1 = min(Y(:));
axis image;

ax2 = subplot(1, 2, 2);
h2 = imagesc(Yw(:, :, 1));
cmin2 = min(Yw(:));
cmax2 = max(Yw(:));
axis image;

mov(size(Y, 3)) = struct('cdata', [], 'colormap', []);
for i = 1:size(Y, 3)
    set(h1, 'CData', Y(:, :, i));
    set(ax1, 'CLim', [cmin1, cmax1]); 
    
    set(h2, 'CData', Yw(:, :, i));
    set(ax2, 'CLim', [cmin2, cmax2]); 
    
    mov(i) = getframe(gcf);
end

v = VideoWriter('SLEEP1_whitened.avi');
open(v);
for i = 1:size(Y, 3)
    writeVideo(v, mov(i));
end
close(v);
