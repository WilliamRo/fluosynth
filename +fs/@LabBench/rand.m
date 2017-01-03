function img = rand(varargin)
%RAND ...
%   ...

% check input
narginchk(0, 2);
[H, W] = deal(500);
if nargin == 1, [H, W] = deal(varargin{1}); end
if nargin == 2, [H, W] = deal(varargin{1}, varargin{2}); end

% initialize
img = zeros(H, W);

end

