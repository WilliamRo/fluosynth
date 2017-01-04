function varargout = rotate(this, matrix)
%TARGET::ROTATE ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2 || isempty(matrix), 
    matrix = orth(rand(3)); 
end

% rotate
this.Body = (matrix * this.Body')';

% output
if nargout > 0, varargout{1} = matrix; end

end

