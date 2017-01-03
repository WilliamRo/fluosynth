function cilia = rand(num)
%CILIUM::RAND ...
%   ...

% check input
narginchk(0, 1)
if nargin < 1, num = 1; end

% generate cilia
cilia = cell(num, 1);
for i = 1 : num
    index = fs.targets.Cilium.roll;
    
    cilia{i} = fs.targets.Cilium(p, 't', d);
end
if num == 1, cilia = cilia{1}; end

end