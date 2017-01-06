classdef  (Abstract) Microscope < handle
    %MICROSCOPE ...
    %   ...
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Specimen = []
        NoiseParams = struct('gaussian', [])
    end
    %% Public Methods
    methods (Access = public)
        setSpecimen(this, specimen)
        setNoise(this, varargin)
    end    
    %% (Abstract) Public Methods
    methods (Abstract, Access = public)
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel)
    end
    %% Static Methods
    methods (Static, Access = public)
        image = addRuler(image)
    end
    %% Private Methods
    methods (Access = protected)
        image = addNoise(this, image)
        % [SHOW]
        showPlane(this, z, zexc)
    end
    
end

