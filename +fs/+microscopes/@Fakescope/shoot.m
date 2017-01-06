function image = shoot(this, zpos, channel, verbose)
%FAKESCOPE:SHOOT generates a synthetic image at the given z-position
%   in specimen set to THIS microscope
%
%   SYNTAX: image = fakescope.shoot(zpos, channel, verbose)
%

assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;

%% check input
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
for i = 1 : length(specimen.Channels(channel).targets)
    target = specimen.Channels(channel).targets(i).target;
    cntall = cntall + length(target.Concentration);
    ofst = specimen.Channels(channel).targets(i).position - ...
           target.BasePoint;
    % for each point in target
    for j = 1 : size(target.Body, 1)
        coord = round(target.Body(j, :) + ofst);
        if ~specimen.inbound(coord), continue; end
        % calculate decay coefficient
        coef = pct(coord(3)) * target.Concentration(j);
        % merge point spread img into image
        if coef > 0
            cnt = cnt + 1;
            image = fs.utils.merge(image, coef * spread, coord(1:2));
        end
    end % end for j
end % end for i
timespan = toc;
% add noise
image = this.addNoise(image);

%% show details
if verbose
    fprintf('>> Elapsed time for %d/%d points is %.3f secs.\n', ...
            cnt, cntall, timespan);
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
    for i = 1 : length(specimen.Channels(channel).targets)
        target = specimen.Channels(channel).targets(i).target;
        if ~target.Interest, continue; end
        z = round(specimen.Channels(channel).targets(i).position(3));
        z = max(1, min(specimen.Shape(3), z));
        illu = pct(z) * mean(target.Concentration);
        plot(z, illu, 'rs', 'MarkerSize', 4)
    end
    title('Total Decay')
    % show image
    subplot(4, 2, 3:2:7)
    imshow(fs.microscopes.Microscope.addRuler(image))
    title('Image')
    % show specimen
    subplot(4, 2, 4:2:8)
    specimen.plot(channel, 0)
    this.showPlane(zpos, exz)
    title('Specimen')
end

end

