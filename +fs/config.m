classdef (Sealed, Abstract) config
    %...
    %   ...
    
    %% Constants
    properties (Constant)
        LengthPerPixel = 0.163       % um
    end
    %% Properties
    methods (Static)
        function val = lpp(~)
            val = fs.config.LengthPerPixel;
        end
    end
    
end

