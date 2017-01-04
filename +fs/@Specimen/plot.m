function plot(this, channel, fid)
%SPECIMEN::PLOT ...
%   ...

% check input
if nargin < 3, fid = 0; end
if nargin < 2 || isempty(channel), channel = 1; end
assert(channel <= length(this.Channels), ...
       '!! Channel index out of bound.')
targets = this.Channels(channel).targets;

% open figure window
if fid, figure(fid); else figure(); end

% plot 3d
clf, hold on
for i = 1 : length(targets)
    target = targets(i).target;
    ofst = targets(i).position - target.BasePoint;
    points = target.Body + ...
             repmat(ofst, size(target.Body, 1), 1);
    plot3(points(:, 1), points(:, 2), points(:, 3), ...
          'bo-', 'MarkerSize', 1)
end
%
xlim([0, this.Shape(1)])
ylim([0, this.Shape(2)])
zlim([0, this.Shape(3)])
xlabel('X Axis'), ylabel('Y Axis'), zlabel('Z Axis')
%
title(sprintf('Specimen, channel: %d/%d', ...
              channel, length(this.Channels)))

end

