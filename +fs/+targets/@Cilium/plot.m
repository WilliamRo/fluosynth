function plot(this, fid)
%CILIUM::PLOT ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2, fid = 0; end

% call TARGET::PLOT
plot@fs.targets.Target(this, fid);

% show title
hold on
plot3(this.InitPoints(:, 1), ...
      this.InitPoints(:, 2), ...
      this.InitPoints(:, 3), 'ro', 'MarkerSize', 5)
title(sprintf('Length = %.2f', this.Length))

end

