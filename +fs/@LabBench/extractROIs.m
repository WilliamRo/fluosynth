function extractROIs(varargin)
%EXTRACTROIS ...
%   ...

%% Check inputs, initialize parameters
% set default parameters
ids = [];
f2tRatio = 1;
roiSize = 49;
prefix = 'FS-';
genTable = false;
% overwrite default parameters
index = 1;
while index <= length(varargin)
    name = varargin{index};
    if ischar(name)
        switch lower(name)
            case {'ratio'}
                index = index + 1;
                f2tRatio = varargin{index};
            case {'size', 'roisize'}
                index = index + 1;
                roiSize = varargin{index};
            case {'filename', 'prefix', 'pre'}
                index = index + 1;
                prefix = varargin{index};
            case {'table'}
                genTable = true;
        end
    else ids = name;
    end % if ischar
    % increate index by 1
    index = index + 1;
end % while index <= ...
% check ids
if isempty(ids)
    contents = dir(fs.config.SynthFolder);
    % scan each content in contents
    for i = 3 : length(contents)
        if ~contents(i).isdir || length(contents(i).name) < 2 || ...
                ~all(contents(i).name(1:2) == 'FS')
            continue
        end % if
        % get id
        try
            ids = [ids; str2double(contents(i).name(3:end))];
        catch
            warning('!! Failed to convert string to double.')
        end
    end % for i
end % if isempty

%% Extract ROIs
halfSize = round((roiSize - 1) / 2);
[rois, labels] = deal([]);
for i = 1 : length(ids)
    % get cursor
    cursor = ids(i);
    path = [fs.config.SynthFolder, sprintf('FS%06d', cursor), '/'];
    % check cursor
    if ~exist(path, 'dir'), continue; end
    % load specimen and green channel image
    spPath = [path, sprintf('GT%06d/SP%06d.mat', cursor, cursor)];
    if ~exist(spPath, 'file'), continue; end
    data = load(spPath); % data.specimen contains specimen info
    % check if specimen has Green channel
    flag = false;
    for c = 1 : length(data.specimen.Channels)
        if data.specimen.Channels(c).rgbindex == 2
            flag = true;
            break;
        end
    end % for c
    if ~flag, continue; end
    imgPath = [path, sprintf('FS%06dMG.tif', cursor)];
    if ~exist(imgPath, 'file'), continue; end
    % read image
    image = imread(imgPath);  image = rgb2gray(image);
    % add cilia
    [centers, rads] = deal([]);
    trueCount = 0;
    for j = 1 : length(data.specimen.Targets)
        % get cellpie
        cellpie = data.specimen.Targets{j};
        if isempty(cellpie.Cilium), continue
        else trueCount = trueCount + 1; end
        % get cilium coordinate
        coords = round(cellpie.Cilium.Coordinate);
        center = round((max(coords) + min(coords)) / 2);
        center = center(1:2);
        rads = [rads; norm(max(coords) - min(coords)) / 2];
        centers = [centers; center];
        % out of bound verification
        if ~(all(center - halfSize > 0) && ...
                all(center + halfSize <= data.specimen.Shape(1:2)))
            continue
        end % if out of bound
        % extract roi
        slice = [center - halfSize; center + halfSize];
        rois = cat(3, rois, image(slice(1, 1):slice(2, 1), ...
            slice(1, 2):slice(2, 2)));
        labels = [labels; true];
    end
    % add ~cilia
    falseCount = trueCount * f2tRatio;
    for j = 1 : falseCount
        while true
            % rand a coord
            x = randi([1 + halfSize, size(image, 1) - halfSize]);
            y = randi([1 + halfSize, size(image, 2) - halfSize]);
            % check if (x, y) is near a target
            flag = false;
            for k = 1 : size(centers, 1)
                if norm([x, y] - centers(k, :)) < ...
                        rads(k) + sqrt(2) * halfSize
                    flag = true; break; end
            end % for k
            if flag, continue; end
            % if (x, y) is legal
            center = [x, y];
            slice = [center - halfSize; center + halfSize];
            rois = cat(3, rois, image(slice(1, 1):slice(2, 1), ...
                slice(1, 2):slice(2, 2)));
            labels = [labels; false];
            % break the while true loop
            break;
        end % while true
    end % for j
end % for i

%% Save data
roiSize = halfSize * 2 + 1;
matFilename = [fs.config.SynthFolder, prefix, ...
    sprintf('%dx%dx%d.mat', roiSize, roiSize, length(labels))];
save(matFilename, 'rois', 'labels')
fprintf('>> rois and labels saved to %s.\n', matFilename)
% generate table
if genTable
    rows = length(labels);
    cols = roiSize * roiSize + 1;
    roitable = zeros(rows, cols);
    for i = 1 : rows
        roitable(i, 1:end-1) = reshape(rois(:, :, i), 1, cols-1);
        roitable(i, end) = labels(i);
    end
    % convert array to table
    roitable = array2table(roitable);
    matFilename = [fs.config.SynthFolder, prefix, ...
        sprintf('%dx%dx%d.tb.mat', roiSize, roiSize, length(labels))];
    save(matFilename, 'roitable')
    fprintf('>> table saved to %s.\n', matFilename)
end

end

