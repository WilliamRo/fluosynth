function data = map(data, range)
%PROJECT ...
%   ...

% check input
if nargin < 2, range = [0, 1]; end
assert(length(range(:)) == 2, ...
       'range is illegal while mapping')

% map
data = data - min(data(:));
data = data / max(data(:));
data = data * (range(2) - range(1)) + range(1);

end

