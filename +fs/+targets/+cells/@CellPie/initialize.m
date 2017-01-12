function initialize(this)
%CELLPIE::INITIALIZE ...
%   ...

%% check input, get nucleus information
assert(~isempty(this.Nucleus), '!! Necleus not detected.')
nucleus = this.Nucleus;
len = size(nucleus.Outline, 1);
coord = @(theta) nucleus.Outline(round((len-1)*theta/(2*pi)+1), :);

%% generate vertexes and pits
index = 1;
[thetas, vertexes, pits] = this.randDataPoints(index);
vertex_num = length(thetas);
[this.Vertexes, this.Pits] = deal(zeros(vertex_num, 2));
% this.Vertexes
for i = 1 : vertex_num
    this.Vertexes(i, :) = vertexes(i) * coord(thetas(i));
end
% this.Pits
thetas = [thetas, 2*pi];
vertexes = [this.Vertexes; this.Vertexes(1, :)];
for i = 1 : vertex_num
    low = coord(mean(thetas(i:i+1)));
    high = mean(vertexes(i:i+1, :));
    this.Pits(i, :) = pits(i) * (high - low) + low;
end

%% generate outline
this.Outline = [];
for i = 1 : vertex_num
    t = [thetas(i), mean(thetas(i:i+1)), thetas(i+1)];
    c = [vertexes(i, :); this.Pits(i, :); vertexes(i+1, :)];
    [~, len] = fs.utils.spline(t, c);
    tt = linspace(thetas(i), thetas(i+1), len);
    this.Outline = [this.Outline; fs.utils.spline(t, c, tt)];
end

end

