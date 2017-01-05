classdef  (Abstract) Microscope < handle
    %MICROSCOPE ...
    %   ...
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Specimen = []
    end
    %% Public Methods
    methods (Access = public)
        setSpecimen(this, specimen)
    end    
    %% (Abstract) Public Methods
    methods (Abstract, Access = public)
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel)
    end
    %% Private Methods
    methods (Access = protected)
        showPlane(this, z)
    end
    
end

