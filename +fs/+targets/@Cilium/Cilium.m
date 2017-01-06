classdef (Sealed) Cilium < fs.targets.Target
    %CILIUM ...
    %   ...
    
    %% Constants
    properties (Constant)
        Interest = true
        LengthBoundsUm = [1, 9]        % um
        % [SHOW]
        Color = [0, 0.45, 0.1]
        MarkerSize = 0.8
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
            this.interpolate()
            this.initConcentration()
        end
        %
        plot(this, fid)
        rotate(this, matrix)
        align(this)
    end
    %% Public Static Methods
    methods (Static)
        % Property Methods
        bounds = LengthBoundsPixel
        %
        cilia = rand(number)
        cilium = getTemplate(index, len, transform)
    end
    %% Private Static Methods
    methods (Static, Access = private)
        index = roll
    end
    %% Private Methods
    methods (Access = private)
        setParams(this, ctrlpoints, varargin)
        interpolate(this)
    end
    %% Templates
    properties (Constant)
        Templates = {[ 0,  0.0,  0.0; ...  % almost straight
                       5,  0.8,  0.3; ...
                      10,  0.8,  0.0; ...
                      15,  0.0,  0.0], 2, ...
                     [ 0,  0.5,  0.5; ... 
                       0,  0.4,  0.5; ...
                       0,  0.5,  0.5; ...
                       0,  0.4,  0.5]; ...
                       %
                     [ 0,  0.0,  0.0; ...  % boomerang
                       2,  1.5,  0.1; ...
                      10,  5.6,  0.2; ...
                      18,  1.5,  0.0; ...
                      20,  0.0,  0.0], 2, ...
                     [ 0,  0.0,  0.0; ... 
                       0,  0.4,  0.5; ...
                       0,  1.0,  0.5; ...
                       0,  0.5,  0.5; ...
                       0,  0.0,  0.0]; ...
                       %
                     [ 0,  0.0,  0.0; ...  % curve head
                       5,  0.0,  0.2; ...
                      16,  0.0,  0.5; ...
                      18,  0.0,  0.3; ...
                      20,  3.0,  0.5], 1, ...
                     [ 0,  0.0,  0.5; ... 
                       0,  0.5,  0.0; ...
                       0,  0.0,  0.5; ...
                       0,  0.5,  0.0; ...
                       0,  1.0,  0.5]}
    end
    
end

%% Notes
% Amoung various cell types, the length of the cilium can vary 
%  between 1 and 9 um [1]
%
% [1] Anneloes Dummer1, etc. Measuring the primary cilium
%     length: improved method for unbiased high?throughput 
%     analysis. 2016.

