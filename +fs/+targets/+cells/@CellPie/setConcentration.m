function setConcentration(this)
%CELLPIE::SETCONCENTRATION ...
%   ...

% set concentration for nucleus 
this.Nucleus.setConcentration(this.Nucleus.ConcentrationRange, 3);

% set concentration for cellpie
% outside
setConcentration@fs.targets.Target(this, ...
    this.ConcentrationRange(1, :), 1);
% inside
setConcentration@fs.targets.Target(this.Inside, ...
    this.ConcentrationRange(2, :), 2);

end

