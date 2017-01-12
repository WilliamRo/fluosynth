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
    % calculate len
    t = [thetas(i), mean(thetas(i:i+1)), thetas(i+1)];
    c = [vertexes(i, :); this.Pits(i, :); vertexes(i+1, :)];
    % calculate delta theta
    delta = cart2pol(vertexes(i+1, 2), vertexes(i+1, 1)) - ...
        cart2pol(vertexes(i, 2), vertexes(i, 1));
    if delta < 0, delta = delta + 2*pi; end
    rmean = mean([norm(vertexes(i, :)), norm(vertexes(i+1, :))]);
    len = round(rmean * delta / 1.5);
    % interpolate
    tt = linspace(thetas(i), thetas(i+1), len);
    this.Outline = [this.Outline; fs.utils.spline(t, c, tt)];
end
% calculate thetas
thetas = cart2pol(this.Outline(:, 2), this.Outline(:, 1));
deltas = abs([thetas(2:end); thetas(1)] - ...
    [thetas(end); thetas(1:end-1)]);
mask = deltas > 1;
deltas(mask) = 2*pi - deltas(mask);
% calculate line density
density = max(deltas) ./ deltas;

%% generate body
body = [];
nuzrad = nucleus.ZRadius;
zrad = nuzrad + this.DefaultParams.ZExtend;
amplitude = 2;
minthickrad = 1;
theta0 = cart2pol(nucleus.Outline(1, 2), nucleus.Outline(1, 1));
slope = this.DefaultParams.SlopeBound / (zrad - minthickrad);
% generate spokes for each points on eage
for i = 1 : size(this.Outline, 1)
    % drop
    droprate = 0.06 * density(i);
    if rand < droprate, continue; end
    % get cell radius on this point
    high = norm(this.Outline(i, :));
    theta = thetas(i) - theta0;
    if theta < 0, theta = theta + 2*pi; end
    % get nucleus radius with respect to this point
    low = norm(coord(theta));
    % count of points on this spoke
    basecnt = max(round( ...
        high / nucleus.Thickness * this.DefaultParams.Density), 1); 
    % for each z position
    for z = -zrad : 1 : zrad
        cnt = basecnt;
        distr = sqrt(rand(cnt, 1));
        % generate slope
        highslp = high;
        if abs(z) > minthickrad
            x = abs(z) - minthickrad;
            highslp = (1 - x * slope) * (high - low) + low;
        end
        % keep fluorophore out of nucleus
        if abs(z) <= nuzrad
            distr = distr*(highslp/high-low/high) + low/high;
        end
        % make nucleus edge bright
        if rand < this.DefaultParams.NucleusEdgeCoef
            distr(1) = low/high; end
        % make cell edge bright
        if abs(z) <= minthickrad && ...
                rand < this.DefaultParams.CellEdgeCoef
            distr(end) = 1; 
            distr = [distr; 1];
            cnt = cnt + 1;
        end
        % generate spoke
        spoke = repmat(distr, 1, 2) .* ...
            repmat(this.Outline(i, :), cnt, 1);
        spoke = [spoke, ones(cnt, 1) * z] + ...
            (rand([cnt, 3]) - 0.5) * amplitude * 2;
        body = [body; spoke];
    end % for z
end % for i
this.Body = body;

end

