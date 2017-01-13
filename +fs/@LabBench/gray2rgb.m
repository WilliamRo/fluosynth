function rgbimages = gray2rgb(images, index)
%LABBENCH::GRAY2RGB ...
%   ...

% check input
narginchk(2, 2);
assert(index >= 1 && index <= 3, '!! Input index is illegal.')

% gray to RGB
rgbimages = zeros(size(images, 1), size(images, 2), 3, ...
    size(images, 3));
rgbimages(:, :, index, :) = images;

% apply color map
linearColorMap = fs.LabBench.LinearColorMap{index};
subindex = linearColorMap(1);
maxColor = linearColorMap(2);
rgbimages(:, :, subindex, :) = maxColor * images;

end

