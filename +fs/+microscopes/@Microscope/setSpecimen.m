function setSpecimen(this, specimen)
%MICROSCOPE::SETSPECIMEN ...
%   ...

% check input
narginchk(2, 2)
assert(isa(specimen, 'fs.Specimen'), ...
       '!! Input specimen is illegal.')

% set specimen
this.Specimen = specimen;

end

