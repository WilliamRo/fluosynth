function plot(this)
%CELLPIE::PLOT ...
%   ...

% call TARGET::PLOT
plot@fs.targets.Target(this, fs.config.FigureIDs.target);

% show title
title(sprintf('CellPie (%d points)', this.PointsCount))

end

