function rotate(this, matrix)
%CILIUM::ROTATE ...
%   ...

% check input
narginchk(1, 2)
if nargin < 2, matrix = []; end

% call TARGET::ROTATE
matrix = rotate@fs.targets.Target(this, matrix);

% rotate initpoints
this.InitPoints = (matrix * this.InitPoints')';

end

