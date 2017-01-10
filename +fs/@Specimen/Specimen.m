classdef Specimen < handle
    %SPECIMEN contains multiple channels
    %   SYNTAX: spe = Specimen(shape, channel_num, rgb_indices)
    %
    %   EXAMPLE:
    %   >> spe = fs.Specimen([1000, 1000, 60], 1, 2);
    %   
    %   MAIN STRUCTURE:
    %     - spe.Targets{i}: instance of class Target
    %     - spe.Channels(i): 
    %     |  - energy: [spe.Shape(3)x1 double]
    %     |  - background
    %     |  - rgbindex
    %
    %% Readonly Properties
    properties (GetAccess = public, SetAccess = protected)
        Shape
        Targets = {}
    end
    %% Public Properties
    properties (Access = public)
        Channels = []
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = Specimen(shape, channels, rgb_indices)
            % check inputs
            if nargin < 3, rgb_indices = []; end
            if nargin < 2, channels = 1; end
            if nargin < 1, shape = [500, 500, 60]; end
            % initialize
            this.Shape = shape;
            for i = 1 : channels
                this.Channels(i).energy = zeros(shape(3), 1);
                this.Channels(i).background = 0;
                if length(rgb_indices) < i
                    this.Channels(i).rgbindex = i;
                else this.Channels(i).rgbindex = rgb_indices(i);
                end % end if
            end % end for i
        end
        addTarget(this, target, positoin)
        addRand(this, num)
        setBackground(this, concentration, channel)
        %
        channelIndexCheck(this, index)
        flag = inbound(this, coord)
        % [SHOW]
        plot(this, channel, fid)
        showEnergy(this, channel)
    end
    
end

