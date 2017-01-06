function saveImage(zstack, filename, extension)
%LABBENCH::SAVEIMAGE ...
%   ...

% check input
narginchk(1, 3)
if nargin < 3, extension = 'tif'; end
if nargin < 2, filename = 'synth'; end
assert(ischar(filename), '!! Input filename is illegal.')
assert(ischar(extension), '!! Input extension is illegal.')

% write image to file
prestr = [fs.config.SynthFolder, filename];
for i = 1 : size(zstack, 3)
    index = '';
    if size(zstack, 3) > 1, index = sprintf('%02d', i); end
    imwrite(zstack(:, :, i), [prestr, index, '.', extension])
end

end