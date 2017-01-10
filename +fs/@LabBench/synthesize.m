function synthesize(channel, saveimg, verbose)
%LABBENCH::SYNTHESIZE ...
%   ...

% check input
if nargin < 3, verbose = true; end
if nargin < 2, saveimg = false; end
if nargin < 1, channel = 2; end
if verbose, interval = 0.01; else interval = 0; end

% initialize specimen
s = fs.Specimen([500, 500, 60], 3, [1, 2, 3]);
% set background to s
s.setBackground(0.1, 2)
s.setBackground(0.08, 3)
% add some random targets to s
s.addRand(5)

% initialize fakescope
m = fs.microscopes.Fakescope();
% set specimen to m
m.setSpecimen(s);
% add noises to m
m.setNoise('gaussian', 0.002);
m.setNoise('poisson');

% get z-stack
zstack = m.getZStack(3, channel, interval);

% save to file
if saveimg
    fs.LabBench.saveImage(zstack, [], [], true, 2);
end

end

