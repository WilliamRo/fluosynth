function zstack = getZStack(this, channel, stepsize, varargin)
%MICROSCOPE::GETZSTACK ...
%   zstack = getZStack(stepsize, channel, verbose)

% check input
narginchk(2, 6)
if nargin < 3 || isempty(stepsize), stepsize = 3; end
rgb = isempty(find(strcmp(varargin, 'gray'), 1));

% generate step information, initialize zstack
shape = this.Specimen.Shape;
zs = 1 : stepsize : shape(3);
if rgb, zstack = zeros(shape(1), shape(2), 3, length(zs));
else zstack = zeros(shape(1), shape(2), 1, length(zs)); end

% generate zstack
for i = 1 : length(zs)
    this.illuminate(zs(i), channel);
    zstack(:, :, :, i) = this.shoot(zs(i), channel, varargin{:});
    % verbose
    if ~isempty(find(strcmp(varargin, 'verbose'), 1))
        view(fs.config.BestView), drawnow
        if i ~= length(zs), pause(0.01); end
    end
end

end

