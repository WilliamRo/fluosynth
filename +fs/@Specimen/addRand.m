function addRand(this, num)
%SPECIMEN::ADDRAND ...
%   ...

% check input
if nargin < 2, num = 1; end

% add random cells
for i = 1 : num
    cellpie = fs.targets.cells.CellPie.rand;
    cellpie.setConcentration();
    this.addTarget(cellpie, []);
end

end

