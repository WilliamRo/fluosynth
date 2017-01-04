function r = truncated_randn(range, mid)
%TRUNCATED_RANDN ...
%   ...

% check input 
narginchk(1, 2)
assert(length(range(:)) == 2, '!! Range is illegal')
len = range(2) - range(1);
if nargin < 2, mid = mean(range); end

% rand
r = randn / 6 * len + mid;

% truncate 
r = max(range(1), min(range(2), r));

end

