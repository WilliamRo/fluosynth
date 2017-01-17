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
        img = rand(varargin)
        synthesize(channel, varargin)
        images = gray2rgb(images, index)
        image = addRuler(image)
        saveImage(zstack, filename, extension, ruler, channel)
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

