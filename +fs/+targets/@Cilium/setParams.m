function setParams(this, initpoints, varargin)
%CILIUM::SETPARAMS ...
%   ...

% set initial points
if isempty(initpoints), 
    initpoints = [0, 0, 0; 10, 10, 10];
end
assert(size(initpoints, 1) > 1, 'Not enough data points')
%
this.InitPoints = initpoints;

% set default parameters
this.InitPointsDistr = linspace(0, 1, size(initpoints, 1));

% overwrite default params with user-define params
for i = 1 : 2 : length(varargin)
    value = varargin{i+1};
    switch (lower(varargin{i}))
        case {'t', 'distr', 'initdistr'}
            assert(min(size(value)) == 1, ...
                   'Initial distribution is illegal')
            value = fs.utils.map(value);
            this.InitPointsDistr = value;
    end % switch
end

end

