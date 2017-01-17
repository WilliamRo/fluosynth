%% This script is for level 2 user
% All sizes are in pixel. The default length per pixel is 0.163 um 
% which can be modified by changing fs.config.LengthPerPixel.

%% Set parameters
height = 500;    % in pixels
width = 500;     
thickness = 60;  % 60 pixels is approximately 9.78 um
channels = 3;    % channel number
cellNumber = 5;
stepSize = 3;    % z-stack step size; 3 pixels is around 0.5 um
addRuler = true;

%% Initialize specimen
specimen = fs.Specimen([height, width, thickness], channels);
% set background to specimen
specimen.setBackground(0.05, 1)     % red channel
specimen.setBackground(0.06, 2)     % green channel
specimen.setBackground(0.02, 3)     % blue channel
% add some random cells to s
specimen.addRand(cellNumber)

%% Initialize fakescope
fakescope = fs.microscopes.Fakescope();
% set specimen to fakescope
fakescope.setSpecimen(specimen);
% add noises to fakescope
fakescope.setNoise('gaussian', 0.002);
fakescope.setNoise('poisson');

%% Get Z-Stack
for channel = 1 : channels
    % use
    %    zstack = fakescope.getZStack(channel, stepSize, 'verbose');
    % if you want to see details
    zstack = fakescope.getZStack(channel, stepSize);
    % save z-stack to file
    fs.LabBench.saveImage(zstack, [], [], addRuler, channel);
end