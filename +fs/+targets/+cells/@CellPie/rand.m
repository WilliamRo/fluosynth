function cellpie = rand()
%CELLPIE::RAND ...
%   ...

nucleus = fs.targets.NucleusPie.rand();
cilium = fs.targets.Cilium.rand();
cellpie = fs.targets.cells.CellPie(nucleus, cilium);

end

