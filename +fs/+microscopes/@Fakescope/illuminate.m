function illuminate(this, zpos, channel)
%FAKESCOPE::ILLUMINATE ...
%   ...

assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;

% check input
if nargin < 3, channel = 1; end
upperbound = length(specimen.Channels);
assert(all(and(channel > 0, channel <= upperbound)), ...
       '!! Input channel is illegal')
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

