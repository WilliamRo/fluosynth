function showProfile(this, fid)
%FAKESCOPE::SHOWPROFILE ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2, fid = 0; end

% open figure window
if fid, figure(fid); else figure(); end

% plot
plot(this.AxialProfile)
xlim([0, length(this.AxialProfile)])
ylim([0, 1])
xlabel('Distance')
title('Axial Profile')

end

