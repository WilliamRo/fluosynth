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
[body, inside] = deal([]);
nuzrad = nucleus.ZRadius;
zrad = nuzrad + this.DefaultParams.ZExtend;
theta0 = cart2pol(nucleus.Outline(1, 2), nucleus.Outline(1, 1));
edgePct = this.DefaultParams.Outside(2);
% generate spokes for each points on eage
for i = 1 : size(this.Outline, 1)
    % 1st round drop
    droprate = 0.06 * density(i);
    if rand < droprate, continue; end
    % get cell radius on this point
    high = norm(this.Outline(i, :));
    theta = thetas(i) - theta0;
    if theta < 0, theta = theta + 2*pi; end
    % get nucleus radius with respect to this point
    low = norm(coord(theta));
    % count of points on this spoke
    cnt = max(round( ...
        high / nucleus.Thickness * this.DefaultParams.Density), 1); 
    % for each z position
    for z = -zrad : 1 : zrad
        isinside = abs(z) <= nuzrad;
        % 2nd round drop
        if isinside && rand < this.DefaultParams.InsideDropRate
            continue; end
        if isinside, side = 'inside'; else side = 'outside'; end
        distr = this.DistrAlongSpoke(cnt, side);
        % keep fluorophore out of nucleus
        if isinside, distr = distr*(1 - low/high) + low/high; end
        % generate spoke
        spoke = repmat(distr, 1, 2) .* ...
            repmat(this.Outline(i, :), cnt, 1);
        zpos = (1 - max(distr - 1 + edgePct, 0) / edgePct) * z;
        spoke = [spoke, zpos] + (rand([cnt, 3]) - 0.5) * ...
            this.DefaultParams.Amplitude * 2;
        if isinside, inside = [inside; spoke]; 
        else body = [body; spoke]; end
    end % for z
end % for i
this.Body = body;
% set inside
this.Inside = fs.targets.Mass(inside);
this.SubTargets{2} = this.Inside;

%% set cilium
if ~isempty(this.Cilium)
    % decide position
    index = randi([1, size(this.Outline, 1)]);
    outmost = this.Outline(index, :);
    theta = thetas(index);
    if theta < 0, theta = theta + 2*pi; end
    mupos = coord(theta);
    mu = norm(mupos) / norm(outmost);
    position = fs.utils.truncated_randn([min(mu, 0.2), 1], ...
        mu) * outmost;
    this.Cilium.setPosition([position, 0]);
    % set out mask
    len = size(this.Cilium.Body, 1);
    this.OutMask = false(len, 1);
    coords = this.Cilium.Coordinate;
    for i = 1 : len
        [pos, z] = deal(coords(i, 1:2), coords(i, 3));
        if abs(z) > nuzrad, this.OutMask(i) = true; continue; end
        thetac = cart2pol(pos(2), pos(1));
        [~, index] = min(abs(thetas - thetac));
        this.OutMask(i) = norm(pos) > norm(this.Outline(index, :));
    end % for i
end

end

