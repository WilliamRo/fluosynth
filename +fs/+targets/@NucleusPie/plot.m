function plot(this)
%NUCLEUSPIE::PLOT ...
%   ...

% call TARGET::PLOT
plot@fs.targets.Target(this, fs.config.FigureIDs.target);

% show title
hold on
plot3(this.InitPoints(:, 1), this.InitPoints(:, 2), ...
    zeros(size(this.InitPoints, 1), 1), 'ro', 'MarkerSize', 3)
title(sprintf('Nucleus (%d points)', size(this.Body, 1)))

end

