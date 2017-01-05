function showEnergy(this, channel)
%SPECIMEN::SHOWENERGY ...
%   ...

% check input
if nargin < 2, channel = 1; end

% show energy
figure;
plot(this.Channels(channel).energy);
title(sprintf('Energy in Channel %d/%d', ...
              channel, length(this.Channels)));

end

