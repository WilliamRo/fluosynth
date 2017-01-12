function initialize(this)
%NUCLEUS::INITIALIZE ...
%   ...

%% generate outline
% get curve length
initpoints = [this.InitPoints; this.InitPoints(1, :)];
t = linspace(0, 2*pi, size(initpoints, 1));
[~, len] = fs.utils.spline(t, initpoints);
% interpolate
% ====================================================================
% try to polish kink
% ====================================================================
if true
    t = [t, t(end) + t(2), t(end) + t(3), t(end) + t(4)];
    initpoints = [initpoints; initpoints(2:4, :)];
end
% ====================================================================
tt = linspace(0, 2*pi, len);
outline = fs.utils.spline(t, initpoints, tt);
% set outline
this.Outline = [outline; outline(1, :)];

%% generate body
body = [];
zrad = this.ZRadius;
droprate = 0.2;
amplitude = 3;
% for each outline point
for i = 1 : len
    if rand < droprate, continue; end
    dist = norm(outline(i, :));
    cnt = max(round(dist / this.Thickness * this.DefaultDensity), 1);
    % for each z position
    for z = -zrad : 2 : zrad
        spoke = repmat(sqrt(rand(cnt, 1)), 1, 2) .* ...
            repmat(outline(i, :), cnt, 1);
        spoke = [spoke, ones(cnt, 1) * z] + ...
            (rand([cnt, 3]) - 0.5) * amplitude;
        body = [body; spoke];
    end
end
this.Body = body;

end

