function illuminate(this, zpos, channel)
%FAKESCOPE::ILLUMINATE illuminates specimen set to THIS microscope
%   at a specific z-position
%   SYNTAX: scope.illuminate(zpos, channel)

assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;

% check input
if nargin < 3, channel = 1; end
specimen.channelIndexCheck(channel)
if nargin < 2, zpos = round(specimen.Shape(3) / 2); end

% illuminate
radius = length(this.AxialProfile) - 1;
zmin = max(1, zpos - radius);
zmax = min(specimen.Shape(3), zpos + radius);
tbound = 1 + zmax - zpos;
bbound = 1 + zpos - zmin;
%
energy = zeros(specimen.Shape(3), 1);
energy(zpos:zmax) = this.AxialProfile(1:tbound);
energy(zmin:zpos) = this.AxialProfile(bbound:-1:1);
specimen.Channels(channel).energy = energy;

end

