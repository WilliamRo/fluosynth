function rgbimages = gray2rgb(images, index, bg)
%LABBENCH::GRAY2RGB ...
%   ...

% check input
narginchk(2, 3);
assert(index >= 1 && index <= 3, '!! Input index is illegal.')
if nargin < 3, bg = 0.0; end

% gray to RGB
rgbimages = ones(size(images, 1), size(images, 2), 3, ...
    size(images, 3)) * bg;
rgbimages(:, :, index, :) = images;

end

