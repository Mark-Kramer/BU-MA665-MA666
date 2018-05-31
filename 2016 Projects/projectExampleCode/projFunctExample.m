function [xcorrZ12,output2,output3] = projFunctExample(session,input1,input2)
% function [output1,output2,output3] = projFunctExample(session,input1,input2)
%
% This function presents a format for the inputs and outputs of the function 
% as well as its body. It also provides a format for adding comments and references 
% so future users of the code can delve deeper into the topics covered. (using some info from ref.1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT:
% session:      string. [1, 1]. Name of the session for experimentA.
% input1:       double matrix. [nTrials, nSamp]. input1 is a matrix with all info for experimentA, 
%               divided in trials (nTrials), and time samples (nSamp).
% ...
% inputN:       ...
%
%
%
% OUTPUT: 
% xcorrZ12:     vector. [nTrials,1]. Cross-correlation btween input1 and input2 (zscored).
% output2:      logical vector. [ntrials,1]. Decision vector from analysis made by analysisFun1
% ....
% outputN:      ...
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% REFERENCES: 
% Here add the list of the references used in your project 
% 
% If different references were used at different stages of the project, 
% add references to the header if it introduces or explains a topic, 
% or to the end of the function as a comment, on the left of the line of code, 
% if the reference was used as for that specific part of the code 
% 
% 1) Best coding practices wiki.        Available: https://en.wikipedia.org/wiki/Best_coding_practices.     [8 Nov. 2016]
% 2) Standard score wiki.               Available: https://en.wikipedia.org/wiki/Standard_score    [9 Nov. 2016]
% 3) Yoo, J. C., & Han, T. H. (2009). Fast normalized cross-correlation. Circuits, Systems, and Signal Processing, 28(6), 819–843. http://doi.org/10.1007/s00034-009-9130-7
% 4) Voytek et al., 2013. A method for event-related phase/amplitude coupling. NeuroImage, 64(1), pp.416–424.
% 5) Tort et al., 2010. Measuring Phase-Amplitude Coupling Between Neuronal Oscillations of Different Frequencies. Journal of Neurophysiology, 104(2), pp.1195–1210.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Authors:      Name of the authors. 
% Authors:      Andres, other lab members, Seiji Ozawa, Julio Cortazar
% 
% authors:      v1.1    : date
% Andres:       v.1     : init 8 Nov. 2016
% Andres:       v1.2    : updated variable names. 9 Nov. 2016
%


%% Cross-correlation code
% Define Vars
[nTrials,~] = size(input1); 

% Preallocate memory
xcorrZ12 = nan(nTrials,1);

% Compute zscore (for input1-2) and x-correlation (between input1-2) for each trial
for iTrial = 1:nTrials
    zscore1 = (input1(iTrial,:) - mean(input1(iTrial,:)))./input1(iTrial,:);        % Z-scored data (a simple explanation found in ref.2)
    zscore2 = (input2(iTrial,:) - mean(input2(iTrial,:)))./input2(iTrial,:);        % Z-scored data (a simple explanation found in ref.2)
    xcorrZ12(iTrial,1) = xcorr(zscore1,zscore2,0);              % using zero lag cross-correlation
end

%% Plotting results
hFig = figure;
set(hFig,'PaperPositionMode','auto','Position',[1641 102 1192 636]);
% plot
plot(1:nTrials,xcorrZ12), 
% plot properties
xlabel('Trial number'), ylabel('X-correlation')
title(sprintf('X-correlation for %s',session),'fontweight','bold')

end             % end of function

