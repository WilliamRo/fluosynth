% This script is for level 2 user

% set parameters
height = 500;
width = 500;

% initialize specimen
specimen = fs.Specimen([height, width, 60], 3, [1, 2, 3]);
% set background to s
specimen.setBackground(0.05, 1)
specimen.setBackground(0.06, 2)
specimen.setBackground(0.02, 3)
% add some random targets to s
specimen.addRand(11)

% initialize fakescope
fakescope = fs.microscopes.Fakescope();
% set specimen to m
fakescope.setSpecimen(specimen);
% add noises to m
fakescope.setNoise('gaussian', 0.001);
fakescope.setNoise('poisson');

% get z-stack
stepsize = 3;
image = zeros(height, width, 3);
for channel = channels
    zstack = fakescope.getZStack(channel, stepsize, varargin{:});
    subimg = max(zstack, [], 4);
    image(:, :, channel) = subimg(:, :, channel);
    % save to file
    if ~isempty(find(strcmp(varargin, 'save'), 1))
        fs.LabBench.saveImage(zstack, [], [], true, channel);
    end
end
fs.LabBench.saveImage(image, [], [], true);