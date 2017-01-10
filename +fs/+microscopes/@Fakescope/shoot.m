function image = shoot(this, zpos, channel, verbose)
%FAKESCOPE:SHOOT generates a synthetic image at the given z-position
%   in specimen set to THIS microscope
%
%   SYNTAX: image = fakescope.shoot(zpos, channel, verbose)
%

%% check specimen and input
assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;
% check input
if nargin < 4, verbose = false; end
if nargin < 3 || isempty(channel), channel = 1; end
specimen.channelIndexCheck(channel)
if nargin < 2 || isempty(zpos)
    zpos = round(specimen.Shape(3) / 2); end

%% generate image
tic
image = ones(this.Specimen.Shape(1:2)) * ...
        specimen.Channels(channel).background;
% use default spread function
spread = fs.utils.spread(fs.config.SpreadParams.size, ...
                         fs.config.SpreadParams.sigma);
sigma = fs.config.FakeDecayParams.distance;
disdecay = this.distanceDecay(zpos, sigma);
pct = specimen.Channels(channel).energy .* disdecay;
% for each target in specimen
cnt = 0;  cntall = 0;
for i = 1 : length(specimen.Targets)
    targets = specimen.Targets{i}.AllMembers;
    for k = 1 : length(targets)
        target = targets{k};
        cntall = cntall + size(target.Body, 1);
        coords = round(target.Coordinate);
        % for each point in target
        for j = 1 : size(coords, 1)
            coord = coords(j, :);
            if ~specimen.inbound(coord), continue; end
            % calculate decay coefficient
            coef = pct(coord(3)) * target.Concentration(j, channel);
            % merge point spread img into image
            if coef > 0
                cnt = cnt + 1;
                image = fs.utils.merge(image, coef * spread, coord(1:2));
            end
        end % end for j
    end % end for k
end % end for i
timespan = toc;
% add noise
image = this.addNoise(image);
image = fs.LabBench.gray2rgb(image, ...
    specimen.Channels(channel).rgbindex);

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
    for i = 1 : length(specimen.Targets)
        target = specimen.Targets{i};
        if ~target.Interest, continue; end
        z = round(target.Position(3));
        z = max(1, min(specimen.Shape(3), z));
        illu = pct(z) * mean(target.Concentration(:, channel));
        plot(z, illu, 'rs', 'MarkerSize', 4)
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

