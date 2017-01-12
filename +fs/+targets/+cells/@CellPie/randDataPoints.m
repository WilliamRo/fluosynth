function [thetas, vertexes, pits] = randDataPoints(this, index)
%CELLPIE::RANDDATAPOINTS ...
%   ...

% check input
if nargin < 2, index = 0; end
if ~index, end

% generate thetas
vertex_num = randi(this.DefaultParams.VertexRange);
thetas = linspace(0, 2*pi, vertex_num+1);
thetas = thetas(1:end-1);
% add random offset to thetas
interval = 2*pi/vertex_num;
coef = this.DefaultParams.OffsetCoef;
maxofst = interval * coef / (2*coef + 1);
thetas(2:end) = thetas(2:end) + ...
    (maxofst * (2 * rand(1, vertex_num-1) - 1));

% generate vertexes and pits
range = this.DefaultParams.SpokeRange;
vertexes = rand(vertex_num, 1) * (range(2) - range(1)) + range(1);
maxsigma = 2;
trandn = min(max(randn(vertex_num, 1), -maxsigma), maxsigma) + ...
    maxsigma;
trandn = trandn  / (2 * maxsigma);
pits = trandn * (1 - this.DefaultParams.PitMargin) + ...
    this.DefaultParams.PitMargin;

end

