function showPlane(this, z, zexc)
%MICROSCOPE::SHOWPLANE ...
%   ...

% check specimen
if isempty(this.Specimen), return; end
specimen = this.Specimen;

% check input
if nargin < 3, zexc = []; end
    
% show plane
colour = ones(1, 3) * 0.7;
linestyle = '-';
interval = 20;
[xmax, ymax] = deal(specimen.Shape(1), specimen.Shape(2));
for x = 0 : interval : xmax
    plot3([x, x], [0, ymax], [z, z], linestyle, 'color', colour);
end
for y = 0 : interval : ymax
    plot3([0, xmax], [y, y], [z, z], linestyle, 'color', colour);
end

% mark excite position
if ~isempty(zexc)
    plot3(specimen.Shape(1), specimen.Shape(2), zexc, ...
          's', 'color', [1, 0.2, 0.0])
end

end

