function plot(this, fid)
%TARGET:PLOT ...
%   ...
    
% check input
narginchk(1, 2)
if nargin < 2, fid = 0; end

% open figure window
if fid, figure(fid); else figure(); end

% plot 3D
plot3(this.Body(:, 1), this.Body(:, 2), this.Body(:, 3), ...
      'o-', 'MarkerSize', 2.6)
  
% limit axis
[bd_max, bd_min] = deal(max(this.Body, [], 1), ...
                        min(this.Body, [], 1));
rad = max(abs(bd_max - bd_min)) / 2;
center = mean([bd_max; bd_min]);

xlim([center(1) - rad, center(1) + rad]);
ylim([center(2) - rad, center(2) + rad]);
zlim([center(3) - rad, center(3) + rad]);

end

