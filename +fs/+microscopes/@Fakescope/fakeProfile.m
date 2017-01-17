function y = fakeProfile(bound, sigma)
%FAKESCOPE::FAKEPROFILE ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2, sigma = 26; end
assert(bound > 0, '!! Input bound is illegal')

% generate curve
d = 0 : bound;
y = exp(-d.^2 / (2*sigma*sigma));
% y = normpdf(d, 0, sigma);
y = y / max(y);

end

