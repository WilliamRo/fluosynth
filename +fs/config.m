classdef (Sealed, Abstract) config
    %...
    %   ...
    
    %% Constants
    properties (Constant)
        LengthPerPixel = 0.163       % um
        FakeDecayParams = struct('energy', 60, 'distance', 80)
        FigureIDs = struct('shoot', 800)
        
        % SpreadParams.size must be ODD!
        SpreadParams = struct('size', 17, 'sigma', 1.6)
    end
    %% Properties
    methods (Static)
        function val = lpp(~)
            val = fs.config.LengthPerPixel;
        end
    end
    
end

