function [p, l] = spline(t, c, tt)
%SPLINE ...
%   Example:
%         p = spline(t, c, tt) returns interpolation
%           result
%
%         [~, l] = spline(t, c) returns the length of
%           curve. t = c(:, 1) if empty

% check input
narginchk(2, 3)
if isempty(t), t = c(:, 1); end
if nargin < 3, 
    tt = linspace(t(1), t(end), 1000);
end
assert(min(size(t)) == 1)
assert(min(size(tt)) == 1)

% interpolate
dim = size(c, 2);
num = length(tt);
p = zeros(num, dim);
for i = 1 : dim
    p(:, i) = spline(t, c(:, i), tt);
end

% calculate length
if nargout == 2, 
    l = 0;
    for i = 2 : num
        l = l + norm(p(i, :) - p(i-1, :));
    end
end

end

