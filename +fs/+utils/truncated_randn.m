function r = truncated_randn(range, mid)
%TRUNCATED_RANDN ...
%   ...

% check input 
narginchk(1, 2)
assert(length(range(:)) == 2, 'range is illegal')
len = range(2) - range(1);
assert(len > 0, 'range is illegal')
if nargin < 2, mid = mean(range); end

% rand
r = randn / 6 * len + mid;

% truncate 
r = max(range(1), min(range(2), r));

end

