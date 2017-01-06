function setNoise(this, varargin)
%MICROSCOPE::SETNOISE set noise parameters for THIS microscope
%   SYNTAX scope.setNoise(type1, param1, type2, param2, ...)
%          parami(i = 1, 2, ...) must be a cell array
%
%   EXAMPLE:
%      scope.setNoise(...)

% check input
assert(mod(nargin, 2) == 1, '!! Failed to set noise parameters.')

% set noise parameter
for i = 1 : 2 : length(varargin)
    this.NoiseParams.(varargin{i}) = varargin{i+1};
end

end

