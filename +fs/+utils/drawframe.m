function drawframe(shape, colour, showorigin, offset)
%DRAWFRAME ...
%   ...

% check input
narginchk(1, 4)
if nargin < 4, offset = [0, 0, 0]; end
if nargin < 3 || isempty(showorigin), showorigin = true; end
if nargin < 2 || isempty(colour), colour = ones(1, 3) * 0.6; end

% draw frame
frame = [0, 0, 0; 1, 0, 0; 1, 1, 0; 0, 1, 0; 0, 0, 0; ...
         0, 0, 1; 1, 0, 1; 1, 1, 1; 0, 1, 1; 0, 0, 1; ...
         1, 0, 1; 1, 0, 0; 1, 1, 0; 1, 1, 1; 0, 1, 1; 0, 1, 0];
frame = frame .* repmat(shape, size(frame, 1), 1);     
frame = frame + repmat(offset, size(frame, 1), 1);     
plot3(frame(:, 1), frame(:, 2), frame(:, 3), '-', 'color', colour);

% show origin
if showorigin, plot3(0, 0, 0, 'o', 'color', [1, 0.2, 0.0]); end

end

