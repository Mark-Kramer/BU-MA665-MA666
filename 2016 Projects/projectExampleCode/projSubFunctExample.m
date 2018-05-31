function [output1,output2] = projSubFunctExample(session,input1,input2,typeAnalysis)
% function [output1,output2] = projSubFunctExample(session,input1,input2,typeAnalysis)
%
% This function presents a format for the inputs and outputs of the function 
% as well as its body. It also provides a format for adding comments and references 
% so future users of the code can delve deeper into the topics covered. (using some info from ref.1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT:
% session:          string. Name of the session for experimentA.
% typeAnalysis:     string. Type of analysis performed by the subfunctions using input1 and input2. 
%                   Can be 'xcorr' (for cross-correlation), 'calcium' (calcim imaging),'dimRedu' (dimentionallity reduction),
%                   'fragNet' (network fragility)   
% input1:           double matrix. 
%                   If typeAnalysis is 'xcorr' [nTrials, nSamp]. input1 is a matrix with all info for experimentA, 
%                   divided in trials (nTrials), and time samples (nSamp).
%                   if typeAnalysis is 
% ...
% inputN:           ...
%
%
%
% OUTPUT: 
% output1:          vector. [nTrials,1]. Values given by typeanalysis. 
%                   For 'xcorr' is Cross-correlation between input1 and input2 (zscored).
%                   For 'dimRedu' is ....
% output2:          logical vector. [ntrials,1]. Decision vector from analysis made by analysisFun1
% ....
% outputN:          ...
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
% 3) Yoo, J. C., & Han, T. H.       (2009). Fast normalized cross-correlation. Circuits, Systems, and Signal Processing, 28(6), 819–843. http://doi.org/10.1007/s00034-009-9130-7
% 4) Voytek et al.,                 (2013). A method for event-related phase/amplitude coupling. NeuroImage, 64(1), pp.416–424.
% 5) Tort et al.,                   (2010). Measuring Phase-Amplitude Coupling Between Neuronal Oscillations of Different Frequencies. Journal of Neurophysiology, 104(2), pp.1195–1210.
% 6) Rabha et al.,                  (2015). Fractional Differential Texture Descriptors Based on the Machado Entropy for Image Splicing Detection. Entropy
% 7) Amaral et al.,                 (2000). Classes of small-world networks. PNSA 97, 11149-11152.    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Authors:      Name of the authors. 
% Authors:      Andres, other lab members, Seiji Ozawa, Julio Cortazar
% 
% authors:      v1.1    : date
% Andres:       v.1     : init. 8 Nov. 2016
%

tStart = tic;
switch typeAnalysis
    case 'xcorr'
        %% Cross-correlation code (ref.2)
        % Compute zscore (for input1-2) and x-correlation (between input1-2) for each trial
        output1 = xcorrTrials(input1,input2);
        
    case 'pac'
        %% Phase-amplitude coupling (a nice intro is found in Tort et al. 2010 and in the tutorial ref. 2)
        % This technique evals the amplitude several frequencies and phases.
        [phase,amp] = extractPhaseAmp(input1);          % Code phase [nPhaseVals,nAmpVals]
        output1 = phaseAmpERP(phase,amp);               % Code implementing Voytek et al. 2013 (ref. 3)
        
    case 'calcium'
        %% Calcium imaging (gets a mask for each image and stores it in mask1)
        mask1 = maskCalciumFluor(input1);               % gets a mask for each image and stores it in mask1 using the Machado Extraction algorithm (ref.6)
        output1 = extractCells(input1,mask1);        	% extracts the cells using the mask1
        
    case 'fragNet'
        %% Network fragility (a nice introduction is found in )
        varDescrip = describeNetwork(input3);           % using the concepts give by Amaral et arlk ref.7 describe the network's stable nodes.
        output1 = evalNetworkFragility(varDescrip);      % extract the fragility score
        
    case 'dimRedu'
        %% Dimmentionality reduction
        [var1,~,~] = getVariance(input1);   
        [var2,~,~] = getVariance(input2);   
        [output2,~,~] = dimRedu4(var1,var2);   
        
end

% Total analysis time
tEnd = toc(tStart);
fprintf('Finished all %s analysis for session %s in %0.2f seconds....\n',typoeanalysis,session,tEnd)

end                     % end function 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% SUBFUNCTIONS (if any) %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xcorrZ12 = xcorrTrials(sinput1,sinput2)
% function xcorrZ12 = xcorrTrials(sinput1,sinput2)
%
% Computes the corr-correlation of signals sinput1 and 2 after zscoring
% each trial. sinput1 and 2 must have the same number of trials.
%
% INPUT
% sinput1:      matrix. [nTrials,nSamps]. Signal1, usually in the form of trials and time samples
% sinput2:      matrix. [nTrials,nSamps]. Signal@, usually in the form of trials and time samples
%
% OUTPUT
% xcorrZ12
%
% Authors: 
% Mambru:       v1.1      : init. 8 Nov. 2016
% Andres:       v1.2      : Added warning/return when number of trials does not match. 9 Nov. 2016
%

% Get vars
[nTrials,~] = size(sinput1);
[nTrials2,~] = size(sinput2);

if nTrials2 ~= nTrials1; warning('The number of trials between input1 (%i) and 2 (%i) is not the same!!!',nTrials,nTrials2); return, end

% Preallocate memory
xcorrZ12 = nan(nTrials,1);

% Iterate
for iTrial = 1:nTrials
    zscore1 = (sinput1(iTrial,:) - mean(sinput1(iTrial,:)))./sinput1(iTrial,:);        % Z-scored data (a simple explanation found in ref.2)
    zscore2 = (sinput2(iTrial,:) - mean(sinput2(iTrial,:)))./sinput2(iTrial,:);        % Z-scored data (a simple explanation found in ref.2)
    xcorrZ12(iTrial,1) = xcorr(zscore1,zscore2,0);              % using zero lag cross-correlation
end

end

