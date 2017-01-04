function setParams(this, varargin)
%SPECIMEN::SETPARAMS ...
%   ...

% check inputs
narginchk(1, 4)

% overwrite default params with user-define params
for i = 1 : 2 : length(varargin)
    value = varargin{i+1};
    switch (lower(varargin{i}))
        case {'shape'}
            this.Shape = value;
        case {'channelnum', 'channel'}
            this.ChannelNum = value;
    end % switch
end

end
