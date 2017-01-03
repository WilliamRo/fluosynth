function plot(this, fid)
%CILIUM::PLOT ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2, fid = 0; end

% call TARGET::PLOT
plot@fs.targets.Target(this, fid);

% show title
title(sprintf('Length = %.2f', this.Length))

end

