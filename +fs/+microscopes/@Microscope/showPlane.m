function showPlane(this, z)
%MICROSCOPE::SHOWPLANE ...
%   ...

% check specimen
if isempty(this.Specimen), return; end
specimen = this.Specimen;
    
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

end

