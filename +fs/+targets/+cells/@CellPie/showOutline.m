function showOutline(this)
%CELLPIE::SHOWOUTLINE ...
%   ...

% check input
assert(~isempty(this.Nucleus), '!! Necleus not detected.')

% show nucleus outline
this.Nucleus.showOutline();

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
plot(outline(:, 1), outline(:, 2), '-', 'Color', [0.9, 0.3, 0.1]);

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
title(sprintf('Cell Outline (%d vertexes)', size(this.Vertexes, 1)))

end

