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

% add random cells
for i = 1 : num
    cellpie = fs.targets.cells.CellPie.rand;
    cellpie.setConcentration();
    this.addTarget(cellpie, []);
end

end

