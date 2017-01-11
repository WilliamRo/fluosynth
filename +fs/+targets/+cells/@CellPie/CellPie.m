classdef CellPie < fs.targets.Target
    %CELLPIE ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        DefaultParams = struct(...
            'VertexRange', [6, 12], ...
            'SpokeRange', [1, 3], ...
            'MaxAngle', (2/3)*pi)
        % [SHOW]
        Color = [0.9, 0.3, 0.2]
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
    end
    
end

