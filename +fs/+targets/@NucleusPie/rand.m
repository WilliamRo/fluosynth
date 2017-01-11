function nucleus = rand(minor, distort)
%NUCLEUS::RAND ...
%   ...

%% check input and initialize
if nargin < 2, distort = fs.targets.NucleusPie.DefaultDistort; end
if nargin < 1, minor = fs.targets.NucleusPie.DefaultMinor; end
num_points = 8;

%% rand an outline
major = minor * fs.utils.truncated_randn(...
    [1, fs.targets.NucleusPie.MaxAspectRatio]);
t = linspace(0, 2*pi, num_points + 1);
initpoints = zeros(num_points, 2);
for i = 1 : num_points
    [coefx, coefy] = deal(1);
    if ~(i <= 2 || i == num_points) && true
        coefx = 0.9 + rand * distort;
        coefy = 0.9 + rand * distort;
    end
    initpoints(i, 1) = cos(t(i)) * major * coefx;
    initpoints(i, 2) = sin(t(i)) * minor * coefy;
end
% rotate
matrix = orth(rand(2) - 0.5);
initpoints = (matrix * initpoints')';

%% create nucleus
thickness = fs.targets.NucleusPie.DefaultThickness;
nucleus = fs.targets.NucleusPie(initpoints, thickness);

end

