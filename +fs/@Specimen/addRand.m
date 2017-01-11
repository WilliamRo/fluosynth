function addRand(this, num)
%SPECIMEN::ADDRAND ...
%   ...

% check input
if nargin < 2, num = 1; end

% add random cilia
for i = 1 : num
    cilium = fs.targets.Cilium.rand;
    cilium.setConcentration([0.95, 1], 2);
    this.addTarget(cilium, []);
end

% add random nucleus
for i = 1 : num
    nucleus = fs.targets.NucleusPie.rand;
    nucleus.setConcentration(nucleus.ConcentrationRange, 3);
    this.addTarget(nucleus, []);
end

end

