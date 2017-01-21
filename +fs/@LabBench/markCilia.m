function image = markCilia(image, specimen, margin, color)
%LABBENCH::MARKCILIA ...
%   ...

% check input
narginchk(2, 4)
[H, W, C] = size(image);
assert(C == 3, '!! Input image must be a RGB image.')
if nargin < 4, color = [1, 1, 0]; end
if nargin < 3, margin = 8; end
color = reshape(color, 1, 1, 3);

% mark each cilium
for i = 1 : length(specimen.Targets)
    % get cellpie
    cellpie = specimen.Targets{i};
    if isempty(cellpie.Cilium), continue; end
    cilium = cellpie.Cilium;
    % get cilium coordinate and 4 edges
    coords = round(cilium.Coordinate);
    top = min(coords(:, 1)) - margin;
    bottom = max(coords(:, 1)) + margin;
    left = min(coords(:, 2)) - margin;
    right = max(coords(:, 2)) + margin;
    if top > H || bottom < 1 || left > W || right < 1, continue; end
    % get vertical and horizontal lines
    vertical = max(top, 1) : min(bottom, H);
    horizontal = max(left, 1) : min(right, W);
    vcolor = repmat(color, length(vertical), 1, 1);
    hcolor = repmat(color, 1, length(horizontal), 1);
    % draw top
    if top >= 1, image(top, horizontal, :) = hcolor; end
    % draw bottom
    if bottom <= H, image(bottom, horizontal, :) = hcolor; end
    % draw left
    if left >= 1, image(vertical, left, :) = vcolor; end
    % draw right
    if right <= W, image(vertical, right, :) = vcolor; end
end

end

