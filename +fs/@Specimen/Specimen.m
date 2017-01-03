classdef Specimen < handle
    %SPECIMEN ...
    %   Example:
    %   >> spe = FS.Specimen(); size(spe(2))
    %   >> ans = 
    %                1000    1000    500
    %
    %% Constants
    properties (GetAccess = public)
        %
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        Shape = [1000, 1000, 500]
        ChannelNum = 2
        Distribution = {}               % fluorescence distribution
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
        function volumn = subsref(this, S)
            assert(length(S.subs) == 1)
            volumn = this.Distribution{S.subs{1}};
        end
    end
    %% Private Methods
    methods (Access = private) 
        setParams(this, varargin)
        initialize(this)
    end
    
end

