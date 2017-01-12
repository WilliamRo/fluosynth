function cellpie = rand()
%CELLPIE::RAND ...
%   ...

nucleus = fs.targets.NucleusPie.rand();
cellpie = fs.targets.cells.CellPie(nucleus);

end

