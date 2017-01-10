function zstack = getZStack(this, stepsize, channel, verbose)
%MICROSCOPE::GETZSTACK ...
%   zstack = getZStack(stepsize, channel, verbose)

% check input
if nargin < 4, verbose = false; end
if nargin < 3 || isempty(channel), channel = 1; end
if nargin < 2 || isempty(stepsize), stepsize = 3; end

% generate step information, initialize zstack
shape = this.Specimen.Shape;
zs = 1 : stepsize : shape(3);
zstack = zeros(shape(1), shape(2), 3, length(zs));

% generate zstack
for i = 1 : length(zs)
    this.illuminate(zs(i), channel);
    zstack(:, :, :, i) = this.shoot(zs(i), channel, verbose);
    % verbose
    if verbose
        view(fs.config.BestView)
        if i ~= length(zs), pause(verbose); end
    end
end

end

