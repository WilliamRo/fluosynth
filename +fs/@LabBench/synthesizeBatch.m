function synthesizeBatch(batches, varargin)
%LABBENCH::BATCHSYNTHESIZE ...
%   ...

%% Check input, initialize parameter
narginchk(0, 20)
if nargin < 1, batches = 1; end
% set default parameters
[height, width, depth] = deal(1000, 1000, 60);
stepSize = 3;
channels = [1, 2, 3];
cellCount = [8, 12];
backgrounds = [1, 0.05; 2, 0.06; 3, 0.02];
noises = {'gaussian', 0.001, 'poisson'};
ruler = false;
% overwrite default parameters
index = 1;
while index <= length(varargin)
    name = varargin{index};
    if ischar(name)
        switch lower(name)
            case {'size', 'scale'}
                val = varargin{index+1};
                assert(length(val) == 2, '!! Input size is illegal.')
                [height, width] = deal(val(1), val(2));
            case {'step', 'stepsize'}
                stepSize = varargin{index+1};
                assert(length(stepSize) == 1, ...
                    '!! Input step size is illegal.')
            case {'depth'}
                depth = varargin{index+1};
            case {'channels', 'channel'}
                channels = varargin{index+1};
                channels = unique(channels(:));
                assert(all(channels < 4) && all(channels > 0), ...
                    '!! Input channels is illegal.')
            case {'count', 'cellcount'}
                cellCount = varargin{index+1};
                assert(length(cellCount) <= 2, ...
                    '!! Input cell count is illegal.')
            case {'bg', 'background', 'backgrounds'}
                backgrounds = varargin{index+1};
                assert(size(backgrounds, 2) == 2, ...
                    '!! Input background is illegal.')
            case {'noise', 'noises'}
                noises = varargin{index+1};
                assert(iscell(noises), '!! Input noises is illegal.')
            case {'ruler', 'addruler', 'useruler'}
                ruler = true;
        end % switch
    end % if ischar(name)
    index = index + 1;
end
% further process
if length(cellCount(:)) == 1, cellCount = repmat(cellCount, 1, 2); end
% display
batchStr = 'batch';
if batches > 1, batchStr = [batchStr, 'es']; end
fprintf('>> Start to synthesize %d %s of images ...\n', ...
    batches, batchStr);

%% Create a fakescope
fakescope = fs.microscopes.Fakescope();
% add noises to m
fakescope.setNoise(noises{:});
fakescope.setNoise('poisson');
% display
disp('>> fakescope instantiated.');

%% Synthesize
cursor = 0;
for i = 1 : batches
    fprintf('>> synthesizing batch %d / %d ...\n', i, batches);
    % create specimen
    specimen = fs.Specimen([height, width, depth], 3);
    % set background to specimen
    for j = 1 : size(backgrounds, 1)
        specimen.setBackground(backgrounds(j, 2), backgrounds(j, 1))
    end
    % add random cells to specimen
    specimen.addRand(randi(cellCount))
    % set specimen to fakescope
    fakescope.setSpecimen(specimen)
    disp('>> specimen created and set to fakescope.');
    % create folder name
    while true
        cursor = cursor + 1;
        outtername = sprintf('FS%06d', cursor);
        path = [fs.config.SynthFolder, outtername, '/'];
        if ~exist(path, 'dir'), mkdir(path); break; end
    end % while
    % create GF(ground truth) folder
    gtpath = [path, sprintf('GT%06d/', cursor)];
    mkdir(gtpath)
    % save specimen to gtpath
    save([gtpath, sprintf('SP%06d.mat', cursor)], 'specimen')
    % initialize zmerges and final image
    zmergeds = zeros(height, width, 3, length(channels));
    image = zeros(height, width, 3);
    % traverse channels
    for channel = channels
        channelStr = fs.LabBench.ChannelNames{channel};
        innername = sprintf('%sS%s', outtername, channelStr);
        zstack = fakescope.getZStack(channel, stepSize);
        % save z-stack to correponding folder
        stackpath = [path, innername, '/'];
        mkdir(stackpath)
        for k = 1 : size(zstack, 4)
            filename = sprintf('%s%02d.tif', innername, k);
            % add ruler
            if ruler, zstack(:, :, :, k) = ...
                    fs.LabBench.addRuler(zstack(:, :, :, k)); end
            % save to file
            imwrite(zstack(:, :, :, k), [stackpath, filename])
        end % for k
        % merge z-stack and save
        zmergeds(:, :, :, channel) = max(zstack, [], 4);
        imwrite(zmergeds(:, :, :, channel), ...
            [path, sprintf('%sM%s.tif', outtername, channelStr);])
        % set zmergeds(:, :, :, channel) to final image
        rgbindex = specimen.Channels(channel).rgbindex;
        image(:, :, rgbindex) = zmergeds(:, :, rgbindex, channel);
        % mark cilia
        if rgbindex == 2
            markers = fs.LabBench.markCilia( ...
                zmergeds(:, :, :, channel), specimen);
            imwrite(markers, ...
                [gtpath, sprintf('%s-Cilia.tif', outtername);])
        end
    end % for channel = channels
    % save final image
    imwrite(image, [path, outtername, 'M.tif']);
    % display
    fprintf('>> Images saved to ''%s''.\n\n', path);
end % for i = 1 : batches

end

