function varargout = gen_dots_and_cilia(S, R)
%% GEN_DOTS_AND_CILIA
%   ...
% 
%  Parameters
%    S : integer, image size
%    R : integer, dot radius (unit: pixel)

%% Check inputs
if nargin < 2, R = 5; end
if nargin < 1, S = 600; end

%% Put dots on an empty canvas
% initialize image
img = zeros(S);
%   o -- y
%   | 
%   x
% [ox, oy] = deal(R);
o = 2 * R;
% generate dot template
sigma = R / 3;
[Y, X] = meshgrid(-R : R);
dot = (1/(sqrt(2*pi)*sigma))*exp(-(X.^2+Y.^2)/(2*sigma^2));
dot = dot / max(dot(:));
% place dots
index = 0;
coord = @(k) round(0.7 * R * (k + 1) * (k + 2) / 2 + o);
while true
    edge = coord(index);
    % determine whether to break
    if edge > S, break; end
    % (0, index) => (index-1, index) [truncated vertical]
    for cursor = 0 : index - 1
        x = coord(cursor);
        img = imembed(img, dot, x, edge);
    end
    % (index, 0) => (index, index)   [intact horizontal]
    for cursor = 0 : index
        y = coord(cursor);
        img = imembed(img, dot, edge, y);
    end
    % increase index by 1
    index = index + 1;
end % while true

%% Put cilia

%% Output or show image
if nargout == 0
    viewer = imv.ImageViewer;
    viewer.addImage(img, ...
        sprintf('Dots and Cilia (%dx%d, R=%d)', S, S, R));
    viewer.view
else
    varargout{1} = img;
end

end

%% Image embed
function img = imembed(img, piece, x, y)

% get image sizes
[H, W] = size(img);
[h, w] = size(piece);

% find ranges
[osx, osy] = deal(floor(h / 2), floor(w / 2));
xrange = (1 : h) + x - osx + 1;
yrange = (1 : w) + y - osy + 1;

% check bounds
if ~all([xrange(1) > 0, yrange(1) > 0, ...
        xrange(2) <= H, yrange(2) <= W]), return; end

% embed piece into img
img(xrange, yrange) = img(xrange, yrange) + piece;

end
















