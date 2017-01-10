function image = addRuler(image)
%LABBENCH::ADDRULER ...
%   ...

% set parameters
len = 50;
margin = [8, 36];
height = 10;

% add white bar
width = round(len / fs.config.LengthPerPixel);
[H, W] = size(image);
assert(width < W - margin(1), '!! Bar is too long for image.')
irange = (1 : height) + H - margin(2) - 1; 
jrange = (1 : width) + margin(1);
peak = 1.0;
image(irange, jrange, :) = peak;

% add text
text_str = sprintf('%d um', len);
box = fs.utils.textbox(text_str);
box = box / max(box(:)) * peak;
[h, w] = size(box);
i = H - 27 + 10;
j = round(mean([jrange(1), jrange(end)]) - w / 2);
for channel = 1 : size(image, 3)
    image(i:i+h-1, j:j+w-1, channel) = ...
        min(image(i:i+h-1, j:j+w-1, channel) + box, peak);
end

end

