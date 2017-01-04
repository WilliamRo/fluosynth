function cilia = rand(num)
%CILIUM::RAND ...
%   ...

% check input
narginchk(0, 1)
if nargin < 1, num = 1; end

% config
bounds = fs.targets.Cilium.LengthBoundsPixel;
mid = bounds(1) + (bounds(2) - bounds(1)) * 0.6;

% generate cilia
cilia = cell(num, 1);
for i = 1 : num
    % rand length
    len = fs.utils.truncated_randn(bounds, mid);
    % rand shape pattern
    cilia{i} = fs.targets.Cilium.getTemplate([], len, true);
    % rand angle
    cilia{i}.rotate();
    % align to origin
    cilia{i}.align();
end
if num == 1, cilia = cilia{1}; end

end