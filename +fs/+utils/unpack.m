function varargout = unpack(array)
%UNPACK ...
%   ...

% check input
narginchk(1, 1)

% unpack array
array = array(:);
N = length(array);
varargout = cell(N, 1);
for i = 1 : N
    varargout{i} = array(i);
end

%
if nargout == 1, varargout{1} = varargout; end

end

