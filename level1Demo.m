%% This script is for level 1 user
% For each channel, a stack of images correponding to different 
% z positions will be synthesized. All images will be merged to 
% fully depict the whole specimen.
clc, fs.LabBench.synthesize([1, 2, 3], 'save')