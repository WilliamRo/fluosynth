function saveImage(zstack, filename, extension, ruler)
%LABBENCH::SAVEIMAGE ...
%   ...

% check input
narginchk(1, 4)
if nargin < 4, ruler = false; end
if nargin < 3 || isempty(extension), extension = 'tif'; end
if nargin < 2 || isempty(filename), filename = 'synth'; end
assert(ischar(filename), '!! Input filename is illegal.')
assert(ischar(extension), '!! Input extension is illegal.')

% write image to file
prestr = [fs.config.SynthFolder, filename];
for i = 1 : size(zstack, 3)
    index = '';
    if size(zstack, 3) > 1, index = sprintf('%02d', i); end
    if ruler
        zstack(:, :, i) = fs.LabBench.addRuler(zstack(:, :, i));
    end
    imwrite(zstack(:, :, i), [prestr, index, '.', extension])
end

end