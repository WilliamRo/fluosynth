classdef CellPie < fs.targets.Target
    %CELLPIE ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        ConcentrationRange = struct(...
            'Outside', [0.6, 0.9], ...
            'Inside', [0.2, 0.8])
        DefaultParams = struct(...
            'VertexRange', [12, 20], ...
            'SpokeRange', [2, 5], ...
            'PitMargin', 0.26, ...
            'MaxAngle', (2/3)*pi, ...
            'OffsetCoef', 4, ...
            'ZExtend', 2, ...
            'Density', 0.3, ...
            'DistrPointsCount', 1000, ...
            'Inside', [4, 0.3], ...
            'Outside', [1.5, 0.1], ...
            'InsideDropRate', 0.6, ...
            'Amplitude', 1.5) 
        % [SHOW]
        Color = [0.9, 0.3, 0.3]
        MarkerSize = 0.6
        PlotStyle = '.'
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Nucleus
        Cilium
        OutMask
        Inside
        Vertexes
        Pits
        Outline
    end 
    %% Private Properties
    properties (Access = protected)
        VariablePool = struct('Inside', [], 'Outside', [])
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = CellPie(nucleus, cilium)
            % check input
            assert(isa(nucleus, 'fs.targets.NucleusPie'), ...
                '!! Input nucleus is illegal.')
            % set parameters
            [this.Nucleus, this.SubTargets{1}] = deal(nucleus);
            this.Cilium = cilium;
            if ~isempty(cilium), this.SubTargets{3} = cilium; end
            % initialize
            this.initialize()
        end
        % Property Methods
        function p = BasePoint(~)
            p = [0, 0, 0];
        end
        mask = Mask(this, side)
        % [SHOW]
        showOutline(this)
        plot(this)
    end
    %% Static Methods
    methods (Static)
        cellpie = rand()
    end
    %% Private Methods
    methods (Access = private)
        initialize(this)
        [thetas, vertexes, pits] = randDataPoints(this, index)
        % Property Methods
        distr = DistrAlongSpoke(this, count, varargin)
    end
    
end

