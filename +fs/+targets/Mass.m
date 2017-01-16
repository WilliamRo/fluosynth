classdef Mass < fs.targets.Target
    %MASS ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = false
        % [SHOW]
        Color = [0.68, 0.90, 0.60]
        MarkerSize = 0.6
        PlotStyle = '.'
    end
    %% Public Methods
    methods (Access = public)
         % Constructor
        function this = Mass(body)
            % check input
            narginchk(1, 1)
            % set and initialize parameters
            this.Body = body;
            this.Concentration = zeros(size(body, 1), 1);
        end
        % Property Methods
        function p = BasePoint(~)
            p = [0, 0, 0];
        end
    end
    %% Static Methods
    methods (Static)
        function mass = rand()
            mass = [];
        end
    end
    
end

