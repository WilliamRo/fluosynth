function img = spread(sz, sigma)
%SPREAD ...
%   ...

% check input
if nargin < 2, sigma = 2.2; end
if nargin < 1, sz = 17; end

% generate img
img = fspecial('gaussian', sz, sigma);

end

