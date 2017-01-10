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
zrad = floor(this.Thickness / 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : len
    dist = norm(outline(i, :));
    cnt = round(dist / 2);
    x = linspace(0, outline(i, 1), cnt)';
    y = linspace(0, outline(i, 2), cnt)';
    body = [body; [x, y, zeros(cnt, 1)]];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
this.Body = body;

end

