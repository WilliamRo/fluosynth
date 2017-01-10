function saveImage(zstack, filename, extension, ruler, channel)
%LABBENCH::SAVEIMAGE ...
%   ...

% check input
narginchk(1, 5)
if nargin < 5 || isempty(channel), channel = 0; end
if nargin < 4 || isempty(ruler), ruler = false; end
if nargin < 3 || isempty(extension), extension = 'tif'; end
if nargin < 2 || isempty(filename), filename = 'synth'; end
assert(ischar(filename), '!! Input filename is illegal.')
assert(ischar(extension), '!! Input extension is illegal.')

% write image to file
switch channel
    case 1
        posstr = 'R';
    case 2
        posstr = 'G';
    case 3
        posstr = 'B';
    otherwise
        posstr = '';
end
prestr = [fs.config.SynthFolder, filename];
for i = 1 : size(zstack, 4)
    index = '';
    if size(zstack, 4) > 1, index = sprintf('%02d', i); end
    if ruler
        zstack(:, :, :, i) = fs.LabBench.addRuler(zstack(:, :, :, i));
    end
    imwrite(zstack(:, :, :, i), ...
        [prestr, index, posstr, '.', extension])
end

end