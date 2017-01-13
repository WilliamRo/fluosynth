classdef  (Abstract) Microscope < handle
    %MICROSCOPE ...
    %   ...
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Specimen = []
        NoiseParams = struct('gaussian', [])
    end
    %% Private Properties
    properties (Access = private, SetObservable)
        % Work Status
        CurrentChannel
        TotalTargetsCount
        Cursor
    end
    %% Public Methods
    methods (Access = public)
        setSpecimen(this, specimen)
        setNoise(this, varargin)
        zstack = getZStack(this, channel, stepsize, varargin)
    end    
    %% Private Methods
    methods (Access = protected)
        image = addNoise(this, image)
        % [SHOW]
        initWorkStatus(this, channel)
        showPlane(this, z, zexc)
    end
    %% (Abstract) Public Methods
    methods (Abstract, Access = public)
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel, varargin)
    end
    
end

