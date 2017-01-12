function setConcentration(this)
%CELLPIE::SETCONCENTRATION ...
%   ...

% set concentration for nucleus 
this.Nucleus.setConcentration(this.Nucleus.ConcentrationRange, 3);

% set concentration for cellpie
setConcentration@fs.targets.Target(this, this.ConcentrationRange, 1);

end

