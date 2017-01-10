function synthesize(saveimg, verbose)
%LABBENCH::SYNTHESIZE ...
%   ...

% check input
if nargin < 2, verbose = true; end
if nargin < 1, saveimg = false; end
if verbose, interval = 0.01; else interval = 0; end

% initialize specimen
s = fs.Specimen([500, 500, 60], 1, 2);
% set background to s
s.setBackground(0.08, 1)
% add some random targets to s
s.addRand(11, 1)

% initialize fakescope
m = fs.microscopes.Fakescope();
% set specimen to m
m.setSpecimen(s);
% add noises to m
m.setNoise('gaussian', interval);
m.setNoise('poisson');

% get z-stack
zstack = m.getZStack(3, 1, 0.1);

% save to file
if saveimg
    fs.LabBench.saveImage(zstack, [], [], true, 2);
end

end

