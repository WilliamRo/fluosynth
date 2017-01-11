function plot(this, channels, fid)
%SPECIMEN::PLOT ...
%   ...

% check input
if nargin < 3, fid = fs.config.FigureIDs.target; end
if nargin < 2 || isempty(channels), channels = [1, 2, 3]; end
assert(all(channels <= length(this.Channels)), ...
       '!! Channel index out of bound.')

% open figure window
if isempty(fid), figure()
elseif fid > 0, figure(fid), clf; end

% plot 3d
hold on
for k = 1 : length(this.Targets)
    targets = this.Targets{k}.AllMembers;
    for i = 1 : length(targets)
        target = targets{i};
        for channel = channels
            if size(target.Concentration, 2) < channel || ...
                    ~target.Concentration(i, channel), continue; end
            points = target.Coordinate;
            plot3(points(:, 1), points(:, 2), points(:, 3), ...
                target.PlotStyle, 'Color', target.Color, ...
                'MarkerSize', target.MarkerSize)
        end
    end
end

% draw frame
fs.utils.drawframe(this.Shape)
  
% limit axis
rad = max(this.Shape) / 2 + 20;
xlim([this.Shape(1) / 2 - rad, this.Shape(1) / 2 + rad])
ylim([this.Shape(2) / 2 - rad, this.Shape(2) / 2 + rad])
zlim([this.Shape(3) / 2 - rad, this.Shape(3) / 2 + rad])
xlabel('X Axis'), ylabel('Y Axis'), zlabel('Z Axis')
view(90, 90)

% set title
title(sprintf('Specimen, channel: [%s] / %d', ...
              num2str(channels), length(this.Channels)))

end

