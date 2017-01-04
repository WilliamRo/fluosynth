function addRand(this, num)
%SPECIMEN::ADDRAND ...
%   ...

% check input
if nargin < 1, num = 1; end

% add random cilia
for i = 1 : num
    cilium = fs.targets.Cilium.rand;
    cilium.setConcentration();
    this.addTarget(cilium);
end

end

