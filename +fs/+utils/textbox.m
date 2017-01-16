function box = textbox(text_str, font_size)

% check input
narginchk(1, 2)
if nargin < 2, font_size = 12; end

% initialize box
box = zeros(100, 200);
box = insertText(box, [0, 0], text_str, ...
                 'FontSize', font_size, ...
                 'BoxOpacity', 0, ...
                 'TextColor', 'white');
box = rgb2gray(box);

% vertical trim
vert = sum(box, 2);
imin = find(vert > 0, 1, 'first');
imax = find(vert > 0, 1, 'last');
box = box(imin:imax, :);

% horizontal trim
hori = sum(box, 1);
jmin = find(hori > 0, 1, 'first');
jmax = find(hori > 0, 1, 'last');
box = box(:, jmin:jmax);
             
end