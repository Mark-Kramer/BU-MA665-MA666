%% script to write an input list for the SCC batch run
snrs = [3, 5, 10, 30, 50];
nROIs = 1:7;
noisePWs = 1; % white and pink noise
nTrials = 50; % for every combination of conditions?

fid = fopen('inputList1.txt', 'w');
for s = 1:length(snrs)
    for n = 1:length(nROIs)
        for p = 1:length(noisePWs)
            for i = 1:nTrials
                fprintf(fid, '%i\t%i\t%i\t%i\n', i, nROIs(n), snrs(s), noisePWs(p));
            end
        end
    end
end
fclose(fid);