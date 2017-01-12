function synthesize(channels, varargin)
%LABBENCH::SYNTHESIZE ...
%   ...

% check input
narginchk(1, 5)

% initialize specimen
s = fs.Specimen([1000, 1000, 60], 3, [1, 2, 3]);
% set background to s
s.setBackground(0.05, 1)
s.setBackground(0.06, 2)
s.setBackground(0.02, 3)
% add some random targets to s
s.addRand(12)

% initialize fakescope
m = fs.microscopes.Fakescope();
% set specimen to m
m.setSpecimen(s);
% add noises to m
m.setNoise('gaussian', 0.001);
m.setNoise('poisson');

% get z-stack
stepsize = 3;
for channel = channels
    zstack = m.getZStack(channel, stepsize, varargin{:});
    % save to file
    if ~isempty(find(strcmp(varargin, 'save'), 1))
        fs.LabBench.saveImage(zstack, [], [], true, channel);
    end
end

end

