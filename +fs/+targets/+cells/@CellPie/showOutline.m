function showOutline(this)
%CELLPIE::SHOWOUTLINE ...
%   ...

% check input
assert(~isempty(this.Nucleus), '!! Necleus not detected.')

% show nucleus outline
this.Nucleus.showOutline();
pos = @(theta) this.Nucleus.Outline(...
    round((size(this.Nucleus.Outline, 1)-1)*theta/(2*pi)+1), :);
approutline = pos(linspace(0, 2*pi, 360));
plot(approutline(:, 1), approutline(:, 2), ':', ...
    'Color', ones(3, 1)*0.2);

% limit axis
extend = 20;
rad = this.Nucleus.MaxAspectRatio * this.Nucleus.DefaultMinor * ...
    this.DefaultParams.SpokeRange(2);
xlim([-1, 1] * (rad + extend)), ylim([-1, 1] * (rad + extend))

% show disk
rectangle('Position', rad*[-1, -1, 2, 2], 'Curvature', [1,1], ...
    'EdgeColor', 0.7*ones(1, 3), 'LineStyle', '-')
rectangle('Position', (rad+2)*[-1, -1, 2, 2], 'Curvature', [1,1], ...
    'EdgeColor', 0.6*ones(1, 3), 'LineStyle', '-')

% show outline
outline = [this.Outline; this.Outline(1, :)];
plot(outline(:, 1), outline(:, 2), '-', 'Color', [0.9, 0.3, 0.2]);

% show vertexes and pits
plot(this.Vertexes(:, 1), this.Vertexes(:, 2), 'o', ...
    'MarkerSize', 3, 'Color', [0.8, 0.5, 0.3])
plot(this.Pits(:, 1), this.Pits(:, 2), 's', ...
    'MarkerSize', 3, 'Color', [0.7, 0.1, 0.1])
for i = 1 : size(this.Vertexes, 1)
    len = norm(this.Vertexes(i, :));
    coord = this.Vertexes(i, :) / len * rad;
    plot([0, coord(1)], [0, coord(2)], ':o', 'LineWidth', 1, ...
        'MarkerSize', 2.6, 'Color', [0.8, 0.5, 0.3])
end

% show title
title(sprintf('Cell Outline (%d vertexes, %d points)', ...
    size(this.Vertexes, 1), size(this.Outline, 1)))

end

