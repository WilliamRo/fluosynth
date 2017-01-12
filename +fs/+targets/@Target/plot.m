function plot(this, fid, issub)
%TARGET:PLOT ...
%   ...
    
% check input
narginchk(1, 3)
if nargin < 3, issub = false; end
if nargin < 2, fid = 0; end

% open figure window
if fid, figure(fid); else fid = figure(); end

% plot 3D
if ~issub, clf; hold on; end
body = this.Body + repmat(this.Position, size(this.Body, 1), 1);
plot3(body(:, 1), body(:, 2), body(:, 3), ...
    this.PlotStyle, 'MarkerSize', this.MarkerSize, ...
    'Color', this.Color)

% plot subtargets
for i = 1 : length(this.SubTargets)
    plot@fs.targets.Target(this.SubTargets{i}, fid, true);
end
  
% limit axis
if ~issub
    [bd_max, bd_min] = deal(max(this.Body, [], 1), ...
                            min(this.Body, [], 1));
    rad = max(abs(bd_max - bd_min)) / 2 + 5;
    center = mean([bd_max; bd_min]);

    xlim([center(1) - rad, center(1) + rad])
    ylim([center(2) - rad, center(2) + rad])
    zlim([center(3) - rad, center(3) + rad])
    xlabel('X Axis'), ylabel('Y Axis'), zlabel('Z Axis'), 
end

% draw frame
if ~issub
    fs.utils.drawframe(max(this.Body) - min(this.Body), ...
        [], false, min(this.Body))
end


end

