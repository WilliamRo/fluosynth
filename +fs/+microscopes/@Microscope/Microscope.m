classdef  (Abstract) Microscope < handle
    %MICROSCOPE ...
    %   ...
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Specimen = []
        NoiseParams = struct('gaussian', [])
    end
    %% Private Properties
    properties (Access = private)
        ProgressBar = fs.utils.ProgressBar
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
        initProgress(this, channel, total)
        function showProgress(this, cursor)
            this.ProgressBar.moveCursor(cursor);
        end
        function finishProgress(this)
            this.ProgressBar.finish();
        end
        showPlane(this, z, zexc)
    end
    %% (Abstract) Public Methods
    methods (Abstract, Access = public)
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel, varargin)
    end
    
end

