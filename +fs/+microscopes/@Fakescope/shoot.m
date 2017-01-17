function image = shoot(this, zpos, channel, varargin)
%FAKESCOPE:SHOOT generates a synthetic image at the given z-position
%   in specimen set to THIS microscope
%
%   SYNTAX: image = fakescope.shoot(zpos, channel, ...)
%

%% check specimen and input
assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;
% check input
narginchk(3, 10);
specimen.channelIndexCheck(channel)
assert(zpos >= 1 && zpos <= specimen.Shape(3), ...
    '!! Input z-position is illegal.')
% set optional
verbose = false;
rgb = true;
i = 1;
while i <= length(varargin)
    switch lower(varargin{i})
        case 'verbose'
            verbose = true;
        case 'rgb'
            rgb = true;
        case 'gray'
            rgb = false;
    end
    i = i + 1;
end

%% generate image
tic
image = ones(this.Specimen.Shape(1:2)) * ...
        specimen.Channels(channel).background;
sigma = fs.config.FakeDecayParams.distance;
disdecay = this.distanceDecay(zpos, sigma);
pct = specimen.Channels(channel).energy .* disdecay;
% for each target in specimen
cntall = specimen.TotalTargetsCount(channel);
cnt = 0;  
for i = 1 : length(specimen.Targets)
    targets = specimen.Targets{i}.AllMembers;
    for k = 1 : length(targets)
        target = targets{k};
        if ~target.checkChannel(channel), continue; end
        coords = round(target.Coordinate);
        % get spread parameters
        param = this.SpreadParams.(target.ClassName)(channel, :);
        [index, multi] = deal(param(1), param(2));
        % for each point in target
        for j = 1 : size(coords, 1)
            coord = coords(j, :);
            if ~specimen.inbound(coord), continue; end
            % calculate decay coefficient
            coef = pct(coord(3)) * target.Concentration(j, channel);
            % merge point spread img into image
            if coef > 0, cnt = cnt + 1;
                image = fs.utils.merge(image, coef * multi * ...
                    this.Spreads{index}, coord(1:2));
            end
        end % end for j
    end % end for k
end % end for i
timespan = toc;
% add noise
image = this.addNoise(image);
if rgb, image = fs.LabBench.gray2rgb(image, ...
        specimen.Channels(channel).rgbindex); end

%% show details
if verbose
    figure(fs.config.FigureIDs.shoot), clf
    % show energy and distance decay curve
    subplot(4, 2, 1), hold on
    plot(specimen.Channels(channel).energy, ...
         'Color', [0, 0.447, 0.741])
    plot(disdecay, '--', 'Color', [0.741, 0.447, 0])
    legend('Energy', 'Distance Decay', 'Location', 'Best')
    [~, exz] = max(specimen.Channels(channel).energy);
    title(sprintf('Excite Z = %d,  Shoot Z = %d', exz, zpos))
    % show coeficient curve
    subplot(4, 2, 2), hold on
    plot(pct)
    for k = 1 : length(specimen.Targets)
        targets = specimen.Targets{k}.AllMembers;
        for i = 1 : length(targets) 
            target = targets{i};
            if ~target.checkChannel(channel), continue; end
            if ~target.Interest, continue; end
            z = round(target.Position(3));
            z = max(1, min(specimen.Shape(3), z));
            illu = pct(z) * mean(target.Concentration(:, channel));
            plot(z, illu, 's', 'MarkerSize', 4, 'Color', target.Color)
        end
    end
    title('Total Decay')
    % show image
    subplot(4, 2, 3:2:7)
    imshow(fs.LabBench.addRuler(image))
    title(sprintf('Image, %.3f secs for %d/%d points', ...
                  timespan, cnt, cntall))
    % show specimen
    subplot(4, 2, 4:2:8)
    specimen.plot(channel, 0)
    this.showPlane(zpos, exz)
    title('Specimen')
end

end

