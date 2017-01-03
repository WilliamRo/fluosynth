function p = spline(t, c, tt)
%SPLINE ...
%   ...

% check input
narginchk(3, 3)
assert(min(size(t)) == 1)
assert(min(size(tt)) == 1)

% interpolate
dim = size(c, 2);
len = length(tt);
p = zeros(len, dim);
for i = 1 : dim
    p(:, i) = spline(t, c(:, i), tt);
end

end

