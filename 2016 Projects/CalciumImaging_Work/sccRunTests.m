function sccRunTests(inputList, tidx, svDir)
% sccRunTests(inputList, tidx, svDir) is a wrapper function to run
% testCaImGetROIsOnSimulation on the shared computing cluster.
% Inputs:
%   inputList - a txt file describing the parameters for each trial run.
%       Each line contains the trial index, number of ROI, snr, noisePW
%   tidx - SGE job index, use the parameters from this line in inputList
%   svDir - path to direction where out files will be saved
% Outputs:
%   out_tidx.mat files are saved into svDir and contain variables out,
%   truthMap, ROI, params

params = struct(...
    'size', 30,...
    'duration', 10,...
    'nROI', [],...
    'snr', [],...
    'noisePW', [],...
    'saveMovie', '',...
    'estNeuronRadius', 5,...
    'cutoff', .5);

if ~exist(svDir, 'dir')
    mkdir(svDir); 
end

%% get run parameters from input list
fid = fopen(inputList, 'r');
for i = 1:tidx
    trialIdx = fscanf(fid, '%i', 1);
    nROI = fscanf(fid, '%i', 1);
    snr = fscanf(fid, '%i', 1);
    noisePW = fscanf(fid, '%i', 1);
end
fclose(fid);

%% set parameters, run test, save results
params.nROI = nROI;
params.snr = snr;
params.noisePW = noisePW;

rng(trialIdx); % for using the same simulated data
[out, truthMap, ROI] = testCaImGetROIsOnSimulation(params);

save(fullfile(svDir, sprintf('out_%i.mat', tidx)), 'out', 'truthMap', 'ROI', 'params');
end