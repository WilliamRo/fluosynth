classdef (Abstract) Target < handle
    %TARGET ...
    %   ...
    
    %% Public Properties
    properties (Access = public)
        Concentration
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Body
    end
    %% Public Methods
    methods (Access = public)
        plot(this, fid)
        varargout = rotate(this, matrix)
        varargout = align(this)
        setConcentration(this, pct)
        % Property Methods
        p = BasePoint(this)
    end
    %% Private Methods
    methods (Access = protected)
        initConcentration(this)
    end
    %% (Abstract) Constant Properties
    properties (Abstract, Constant)
        Interest
    end
    %% (Abstract) Static Methods
    methods (Abstract, Static)
        targets = rand(number)
    end
    
end

