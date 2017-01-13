function saveImage(zstack, filename, extension, ruler, channel)
%LABBENCH::SAVEIMAGE ...
%   SYNTAX: saveImage(zstack, filename, extension, ruler, channel)

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
        channelstr = 'R';
    case 2
        channelstr = 'G';
    case 3
        channelstr = 'B';
    otherwise
        channelstr = '';
end
prestr = [fs.config.SynthFolder, channelstr, filename];
for i = 1 : size(zstack, 4)
    index = '';
    if size(zstack, 4) > 1, index = sprintf('%02d', i); end
    if ruler
        zstack(:, :, :, i) = fs.LabBench.addRuler(zstack(:, :, :, i));
    end
    imwrite(zstack(:, :, :, i), ...
        [prestr, index, '.', extension])
end

% ====================================================================
if size(zstack, 4) > 1
    image = max(zstack, [], 4);
    imwrite(image, [prestr, '00', '.', extension]);
%     figure, imshow(image);
end
% ====================================================================

% display information
if isempty(index), objstr = 'Image'; else objstr = 'Image stack'; end
fprintf('>> %s of channel %s saved.\n', objstr, channelstr);

end