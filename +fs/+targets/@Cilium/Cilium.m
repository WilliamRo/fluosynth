classdef (Sealed) Cilium < fs.targets.Target
    %CILIUM ...
    %   ...
    
    %% Constants
    properties (Constant)
        LengthBoundsUm = [1, 9]        % um
    end
    %% Public Properties
    properties (Access = public)
        %
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        InitPoints
        InitPointsDistr
        Length
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Cilium(initpoints, varargin)
            if nargin < 1, initpoints = []; end
            this.setParams(initpoints, varargin{:});
            %
            this.interpolate
        end
        %
        plot(this, fid)
        align(this)
    end
    %% Static Methods
    methods (Static)
        % Property Methods
        bounds = LengthBoundsPixel
        %
        targets = rand(number)
    end
    %% Property Methods
    methods (Access = public)
        %
    end
    %% Private Methods
    methods (Access = private)
        setParams(this, ctrlpoints, varargin)
        interpolate(this)
    end
    
end

%% Notes
% Amoung various cell types, the length of the cilium can vary 
%  between 1 and 9 um [1]
%
% [1] Anneloes Dummer1, etc. Measuring the primary cilium
%     length: improved method for unbiased high?throughput 
%     analysis. 2016.

