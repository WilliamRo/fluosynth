function drawframe(shape, colour, showorigin)
%DRAWFRAME ...
%   ...

% check input
narginchk(1, 3)
if nargin < 3, showorigin = true; end
if nargin < 2, colour = ones(1, 3) * 0.6; end

% draw frame
frame = [0, 0, 0; 1, 0, 0; 1, 1, 0; 0, 1, 0; 0, 0, 0; ...
         0, 0, 1; 1, 0, 1; 1, 1, 1; 0, 1, 1; 0, 0, 1; ...
         1, 0, 1; 1, 0, 0; 1, 1, 0; 1, 1, 1; 0, 1, 1; 0, 1, 0];
frame = frame .* repmat(shape, size(frame, 1), 1);     
plot3(frame(:, 1), frame(:, 2), frame(:, 3), '-', 'color', colour);

% show origin
if showorigin, plot3(0, 0, 0, 'o', 'color', [1, 0.2, 0.0]); end

end
