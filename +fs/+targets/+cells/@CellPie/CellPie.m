classdef CellPie < fs.targets.Target
    %CELLPIE ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        % [SHOW]
        Color = [0, 0.45, 0.1]
        MarkerSize = 0.6
        PlotStyle = '.'
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Body
        Position = [0, 0, 0]
    end 
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = CellPie(nucleus, varargin)
            %
        end
    end
    %% Static Methods
    methods (Static)
        targets = rand(number)
    end
    
end

