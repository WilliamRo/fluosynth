classdef LabBench < handle
    %CREATOR ...
    %   ...
    %%
    properties
    end
    %% Public Static Methods
    methods (Access = public, Static)
        img = rand(varargin)
        img = synthesize()
        image = addRuler(image)
        saveImage(zstack, filename, extension)
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

