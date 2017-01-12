classdef CellPie < fs.targets.Target
    %CELLPIE ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        ConcentrationRange = [0.2, 0.6]
        DefaultParams = struct(...
            'VertexRange', [8, 15], ...
            'SpokeRange', [2, 4], ...
            'PitMargin', 0.26, ...
            'MaxAngle', (2/3)*pi, ...
            'OffsetCoef', 4, ...
            'ZExtend', 1, ...
            'Density', 0.2, ...
            'CellEdgeCoef', 0.9, ...
            'NucleusEdgeCoef', 0.04, ...
            'SlopeBound', 0.5) 
        % [SHOW]
        Color = [0.9, 0.3, 0.3]
        MarkerSize = 0.6
        PlotStyle = '.'
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Nucleus
        Vertexes
        Pits
        Outline
    end 
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = CellPie(nucleus, varargin)
            % check input
            assert(isa(nucleus, 'fs.targets.NucleusPie'), ...
                '!! Input nucleus is illegal.')
            % set parameters
            [this.Nucleus, this.SubTargets{1}] = deal(nucleus);
            % initialize
            this.initialize()
        end
        % Property Methods
        function p = BasePoint(~)
            p = [0, 0, 0];
        end
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
    end
    
end

