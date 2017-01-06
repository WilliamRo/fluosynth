classdef Specimen < handle
    %SPECIMEN contains multiple channels
    %   SYNTAX: spe = Specimen(shape, channel_num)
    %
    %   EXAMPLE:
    %   >> spe = fs.Specimen([1000, 1000, 60], 3);
    %   
    %   MAIN STRUCTURE:
    %     - spe.Channels(i): 
    %     |  - targets(j): 
    %     |  |  - target: instance of class Target
    %     |  |  - position: [1x3 double]
    %     |  - energy: [spe.Shape(3)x1 double]
    %     |  - background
    %
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = private)
        Shape
    end
    %% Public Properties
    properties (Access = public)
        Channels
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Specimen(shape, channels)
            % check inputs
            if nargin < 2, channels = 1; end
            if nargin < 1, shape = [500, 500, 300]; end
            % initialize
            this.Shape = shape;
            for i = 1 : channels
                this.Channels(i).targets = [];
                this.Channels(i).energy = zeros(shape(3), 1);
                this.Channels(i).background = 0;
            end
        end
        addTarget(this, target, positoin, channel)
        addRand(this, num, channel)
        setBackground(this, concentration, channel)
        %
        channelIndexCheck(this, index)
        flag = inbound(this, coord)
        % [SHOW]
        plot(this, channel, fid)
        showEnergy(this, channel)
    end
    
end

