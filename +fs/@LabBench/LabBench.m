classdef LabBench < handle
    %LABBENCH ...
    %   ...
    %%
    properties
    end
    %% Public Static Methods
    methods (Access = public, Static)
        img = rand(varargin)
        synthesize(saveimg, verbose)
        images = gray2rgb(images, index, bg)
        image = addRuler(image)
        saveImage(zstack, filename, extension, ruler)
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

