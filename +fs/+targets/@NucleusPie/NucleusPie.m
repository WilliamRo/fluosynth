classdef (Sealed) NucleusPie < fs.targets.Target
    %NUCLEUS ...
    %   ...
    %% Constants
    properties (Constant)
        Interest = true
        % [SHOW]
        Color = [0.3, 0.5, 0.8]
        MarkerSize = 0.7
        PlotStyle = '.'
        % DEFAULT
        DefaultThickness = 8
        DefaultMinor = 35
        DefaultDistort = 0.2
        DefaultDensity = 0.1
        MaxAspectRatio = 2
        ConcentrationRange = [0.5, 1]
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        InitPoints
        Outline
        Thickness
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = NucleusPie(initpoints, thickness)
            % check input
            narginchk(2, 2);
            % set parameters
            this.InitPoints = initpoints;
            this.Thickness = thickness;
            % initialize
            this.initialize()
        end
        % Property Methods
        p = BasePoint(this)
        zrad = ZRadius(this)
        % [SHOW]
        showOutline(this)
        plot(this)
    end
    %% Static Methods
    methods (Static)
        nucleus = rand(radius)
    end
    %% Private Methods
    methods (Access = private)
        initialize(this)
    end
    
end

