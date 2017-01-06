function setNoise(this, varargin)
%MICROSCOPE::SETNOISE set noise parameters for THIS microscope
%   SYNTAX scope.setNoise(type1, [param1,] type2, [param2,] ...)
%          parami(i = 1, 2, ...) must be a scalar, if omited, 
%          a default parameter will be used.
%
%   EXAMPLE:
%      scope.setNoise('gaussian', 0.05, 'poisson')

% set noise parameter
index = 1;
while index <= length(varargin)
    ntype = varargin{index};  
    param = {};
    assert(ischar(ntype), '!! Noise type is not a string')
    if index+1 <= length(varargin) && ~ischar(varargin{index+1})
        param = varargin(index+1);
        index = index + 1;
    end
    this.NoiseParams.(ntype) = param;
    index = index + 1;
end

end

