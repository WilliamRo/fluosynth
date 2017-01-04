classdef Specimen < handle
    %SPECIMEN ...
    %   Example:
    %   >> spe = FS.Specimen(); size(spe(2))
    %   >> ans = 
    %                1000    1000    500
    %
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        Shape = [1000, 1000, 500]
        ChannelNum = 2
        Channels
    end
    %% Public Properties
    properties (Access = public)
        %
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Specimen(varargin)
            this.setParams(varargin{:})
            this.initialize()
        end
        % Subscript index
        function attr = subsref(this, S)
            if S.type == '.', attr = this.(S.subs); 
            else attr = this.Channels(S.subs{1}); end
        end
        %
        plot(this)
        setTarget(this, target)
    end
    %% Private Methods
    methods (Access = private) 
        setParams(this, varargin)
        initialize(this)
    end
    
end

