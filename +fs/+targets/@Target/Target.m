classdef (Abstract) Target < handle
    %TARGET abstract 3D target, can not be initiated
    %   
    %   MAIN STRUCTURE:
    %     - tgt.SubTargets{i}: instance of class Target
    %
    
    %% Public Properties
    properties (Access = public)
        SubTargets = {}
        Concentration
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Body
        Position = [0, 0, 0]
    end
    %% Public Methods
    methods (Access = public)
        plot(this, fid, issub)
        varargout = rotate(this, matrix)
        varargout = align(this)
        setPosition(this, position)
        setConcentration(this, pct, col, part)
        addSubTarget(this, target, position)
        % Property Methods
        p = BasePoint(this)
        [zl, zh] = Margin(this)
        ofst = Offset(this)
        coords = Coordinate(this)
        targets = AllMembers(this)
    end
    %% Private Methods
    methods (Access = protected)
        initConcentration(this)
    end
    %% (Abstract) Constant Properties
    properties (Abstract, Constant)
        Interest
        Color
        MarkerSize
        PlotStyle
    end
    %% (Abstract) Static Methods
    methods (Abstract, Static)
        targets = rand(number)
    end
    
end

