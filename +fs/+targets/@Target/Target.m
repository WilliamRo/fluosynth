classdef (Abstract) Target < handle
    %TARGET ...
    %   ...
    
    %%
    properties (Access = public)
        %
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
       Body
       Offset = [0, 0, 0]
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Target()
            %
        end
        %
        plot(this, fid)
        ofst = align(this)
    end
    %% (Abstract) Static Methods
    methods (Abstract, Static)
        targets = rand(number)
    end
    
end

