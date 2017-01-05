classdef Fakescope < fs.microscopes.Microscope
    %FAKESCOPE ...
    %   ...
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        AxialProfile
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Fakescope(axpro)
            % check input
            if nargin < 1
                sigma = fs.config.FakeDecayParams.energy;
                axpro = fs.microscopes...
                        .Fakescope.fakeProfile(200, sigma);
            end
            % set parameters
            this.AxialProfile = axpro;
        end
        showProfile(this, fid)
        y = distanceDecay(this, zpos, varargin)
        % Implementation for abstract methods
        illuminate(this, zpos, channel)
        image = shoot(this, zpos, channel, verbose)
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

