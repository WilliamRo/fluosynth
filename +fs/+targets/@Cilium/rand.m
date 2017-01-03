function cilia = rand(num)
%CILIUM::RAND ...
%   ...

% check input
narginchk(0, 1)
if nargin < 1, num = 1; end

% generate cilia
cilia = cell(num, 1);
for i = 1 : num
    [p, d] = randp;
    cilia{i} = fs.targets.Cilium(p, 't', d);
end
if num == 1, cilia = cilia{1}; end

end

%% method to generate a set of 
%   random data points
function [p, d] = randp
p = [0, 2, 0; ...
     2, 0, 0; ...
     4, 0, 0.2; ...
     10, 0, 0; ...
     20, 0, 0];
d = p(:, 1);
end