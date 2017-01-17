function y = distanceDecay(this, zpos, varargin)
%FAKESCOPE::DISTANCEDECAY ...
%   ...

assert(~isempty(this.Specimen), '!! Specimen not set.')
specimen = this.Specimen;

% check input
if nargin < 3, sigma = 26;
else sigma = varargin{1}; end

% generate decay profile
Z = 1 : specimen.Shape(3);
y = fs.utils.normpdf(Z, zpos, sigma);
y = y' / max(y);

end
