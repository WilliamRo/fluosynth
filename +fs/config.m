classdef (Sealed, Abstract) config
    %...
    %   ...
    
    %% Constants
    properties (Constant)
        LengthPerPixel = 0.163       % um
        FakeDecayParams = struct('energy', 5, 'distance', 26)
        FigureIDs = struct('shoot', 800, 'target', 799)
        
        % SpreadParams.size must be ODD!
        SpreadParams = struct('size', 17, 'sigma', [2, 1.2, 3])
        SynthFolder = 'sdata/'
        % [SHOW]
        BestView = [90, 35, 40];
    end
    %% Properties
    methods (Static)
        function val = lpp(~)
            val = fs.config.LengthPerPixel;
        end
    end
    
end

