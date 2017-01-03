function bounds = LengthBoundsPixel
%CILIUM::LENGTHBOUNDSPIXEL ...
%   ...

bounds = fs.targets.Cilium.LengthBoundsUm ./ ...
         fs.config.LengthPerPixel;
bounds(1) = floor(bounds(1));
bounds(2) = ceil(bounds(2));

end

