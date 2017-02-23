function exportROIs(matFilename)
%EXPORTROIS ...
%   ...

% check input
narginchk(0, 1)
if nargin < 1, matFilename = []; end
% if filename is not provided, find 1st .mat file existed
if isempty(matFilename)
    contents = dir(fs.config.SynthFolder);
    for i = 3 : length(contents)
        % get filename
        filename = contents(i).name;
        if all(filename(end-3:end) == '.mat')
            fprintf('>> %s found.\n', filename)
            matFilename = filename;
            break;
        end % for if all ...
    end % for i
end
assert(~isempty(matFilename), '!! .mat file not found.')

% load data and export
data = load([fs.config.SynthFolder, matFilename]);
foldername = [fs.config.SynthFolder, 'tmp/'];
if exist(foldername, 'dir'), rmdir(foldername, 's'); end
mkdir(foldername)
labels = 'FT';
for i = 1 : length(data.labels)
    imwrite(data.rois(:, :, i), ...
        [foldername, sprintf('%s%05dM%d.tif', ...
        labels(data.labels(i) + 1), i, ...
        round(mean(mean(data.rois(:, :, i)))))])
end % for i
fprintf('>> %d images been pulled out to %s\n', ...
    length(data.labels), foldername);

end

