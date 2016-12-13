function [im] = readTifStack(filename,fstart,fend)
% reads in a .tif stack. Optional parameters fstart and fend set the
% starting and ending frames to read

warning('off');
if ~exist('fstart','var') || isempty(fstart)
    fstart = 1;
end
if ~exist('fend','var') || isempty(fend)
    fend = length(imfinfo(filename));
end

N = fend-fstart+1;
t = Tiff(filename);

t.setDirectory(fstart);
im = repmat(t.read(),1,1,N);
for i = 2:N
    t.nextDirectory;
    im(:,:,i) = t.read();
end
t.close;
