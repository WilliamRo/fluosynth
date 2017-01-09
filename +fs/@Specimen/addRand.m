function addRand(this, num, channel)
%SPECIMEN::ADDRAND ...
%   ...

% check input
if nargin < 3, channel = 1; end
if nargin < 2, num = 1; end

% add random cilia
for i = 1 : num
    cilium = fs.targets.Cilium.rand;
    cilium.setConcentration([0.95, 1], channel);
    this.addTarget(cilium, [], channel);
end

end

