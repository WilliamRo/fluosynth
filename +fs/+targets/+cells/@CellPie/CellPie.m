classdef CellPie < fs.targets.Target
    %CELLPIE ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        DefaultParams = struct(...
            'VertexRange', [8, 15], ...
            'SpokeRange', [1.5, 4], ...
            'PitMargin', 0.1, ...
            'MaxAngle', (2/3)*pi, ...
            'OffsetCoef', 4, ...
            'ZExtend', 1, ...
            'Density', 0.5, ...
            'CellEdgeCoef', 0.9, ...
            'NucleusEdgeCoef', 0.07, ...
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
        % [SHOW]
        showOutline(this)
        plot(this)
    end
    %% Static Methods
    methods (Static)
        targets = rand(number)
    end
    %% Private Methods
    methods (Access = private)
        initialize(this)
        [thetas, vertexes, pits] = randDataPoints(this, index)
    end
    
end

