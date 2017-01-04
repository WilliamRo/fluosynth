classdef (Abstract) Target < handle
    %TARGET ...
    %   ...
    
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Body
    end
    %% Public Methods
    methods (Access = public)
        plot(this, fid)
        varargout = rotate(this, matrix)
        varargout = align(this)
        % Property Methods
        p = BasePoint(this)
    end
    %% (Abstract) Static Methods
    methods (Abstract, Static)
        targets = rand(number)
    end
    
end

