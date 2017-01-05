classdef Specimen < handle
    %SPECIMEN ...
    %   Example:
    %   >> spe = fs.Specimen([1000, 1000, 500], 3);
    %
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        Shape
        Channels
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Specimen(shape, channels)
            % check inputs
            if nargin < 2, channels = 1; end
            if nargin < 1, shape = [500, 500, 500]; end
            % initialize
            this.Shape = shape;
            for i = 1 : channels
                this.Channels(i).targets = [];
            end
        end
        plot(this, channel, fid)
        addTarget(this, target, positoin, channel)
        addRand(this, num)
    end
    
end

