classdef Fakescope < fs.microscopes.Microscope
    %FAKESCOPE ...
    %   ...
    %% Constant
    properties (Constant, Access = private)
        SpreadSize = 17                          % size must be ODD!
        SpreadSigmas = [1.2, 2, 2.2, 2.6]
        SpreadIndices = struct('Cilium', 1, ...
                               'NucleusPie', 4, ...
                               'CellPie', 3, ...
                               'Mass', 2)
    end
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        AxialProfile
        Spreads
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Fakescope(axpro)
            % check input
            if nargin < 1
                sigma = fs.config.FakeDecayParams.energy;
                axpro = fs.microscopes...
                        .Fakescope.fakeProfile(100, sigma);
            end
            % set parameters
            this.AxialProfile = axpro;
            % initialize
            this.initialize();
        end
        showProfile(this, fid)
        y = distanceDecay(this, zpos, varargin)
        % Implementation for abstract methods
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel, varargin)
    end
    %% Public Static Methods
    methods (Static, Access = public)
        y = fakeProfile(bound, sigma)
    end
    %% Private Methods
    methods (Access = private)
        %
    end
    
end

