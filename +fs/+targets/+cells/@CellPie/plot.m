function plot(this)
%CELLPIE::PLOT ...
%   ...

% call TARGET::PLOT
plot@fs.targets.Target(this, fs.config.FigureIDs.target);

% show title
hold on
title(sprintf('Nucleus (%d points)', size(this.Body, 1)))

end

