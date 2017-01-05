function image = merge(image, img, pos)
%ABSORB ...
%   ...

% check input
narginchk(3, 3)
s = size(img, 1);
assert(and(s == size(img, 2), mod(s, 2) == 1), ...
       '!! Shape of input img is illegal.')

% find range
rad = (s - 1) / 2;
[H, W] = size(image);
[i, j] = deal(pos(1), pos(2));
% top
T = max(i - rad, 1);
t = 1 + T - (i - rad);
% bottom
B = min(i + rad, H);
b = s - (i + rad - B);
% left
L = max(j - rad, 1);
l = 1 + L - (j - rad);
% right
R = min(j + rad, W);
r = s - (j + rad - R);

% merge
image(T:B, L:R) = image(T:B, L:R) + img(t:b, l:r);

end

