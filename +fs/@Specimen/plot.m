function plot(this, channel, fid)
%SPECIMEN::PLOT ...
%   ...

% check input
if nargin < 3, fid = []; end
if nargin < 2 || isempty(channel), channel = 1; end
assert(channel <= length(this.Channels), ...
       '!! Channel index out of bound.')
targets = this.Channels(channel).targets;

% open figure window
if isempty(fid), figure()
elseif fid > 0, figure(fid), clf; end

% plot 3d
hold on
for i = 1 : length(targets)
    target = targets(i).target;
    ofst = targets(i).position - target.BasePoint;
    points = target.Body + repmat(ofst, size(target.Body, 1), 1);
    plot3(points(:, 1), points(:, 2), points(:, 3), 'o-', ...
          'Color', target.Color, 'MarkerSize', target.MarkerSize)
end

% draw frame
fs.utils.drawframe(this.Shape)
  
% limit axis
rad = max(this.Shape) / 2;
xlim([this.Shape(1) / 2 - rad, this.Shape(1) / 2 + rad])
ylim([this.Shape(2) / 2 - rad, this.Shape(2) / 2 + rad])
zlim([this.Shape(3) / 2 - rad, this.Shape(3) / 2 + rad])
xlabel('X Axis'), ylabel('Y Axis'), zlabel('Z Axis')
view(90, 90)

% set title
title(sprintf('Specimen, channel: %d/%d', ...
              channel, length(this.Channels)))

end

