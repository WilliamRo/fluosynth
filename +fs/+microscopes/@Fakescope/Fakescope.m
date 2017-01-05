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
                axpro = fs.microscopes...
                        .Fakescope.fakeProfile(80);
            end
            % set parameters
            this.AxialProfile = axpro;
        end
        showProfile(this, fid)
        illuminate(this, zpos, channel)
        image = shoot(this)
    end
    %% Public Static Methods
    methods (Static, Access = public)
        y = fakeProfile(bound, sigma)
    end
    
end

