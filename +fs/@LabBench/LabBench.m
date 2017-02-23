classdef LabBench < handle
    %LABBENCH ...
    %   ...
    %%  Constants
    properties (Constant, Access = public)
        ChannelNames = {'R', 'G', 'B'};
        %LinearColorMap = {[2, 0.1647], [1, 0.2353], [2, 0.2353]};
        LinearColorMap = {[2, 0.0647], [1, 0.2353], [2, 0.2353]};
    end
    %% Public Static Methods
    methods (Access = public, Static)
        synthesize(channels, varargin)
        synthesizeBatch(batches, varargin)
        images = gray2rgb(images, index)
        image = addRuler(image)
        saveImage(zstack, filename, extension, ruler, channel)
        image = markCilia(image, specimen, margin, color)
        extractROIs(varargin)
        exportROIs(matFilename)
    end % public static methods
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = LabBench()
        end
    end % public methods
    %% Private Methods
    methods (Access = private) 
        
    end % private methods
    
end

