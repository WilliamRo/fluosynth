function setConcentration(this)
%CELLPIE::SETCONCENTRATION ...
%   ...

% set concentration for nucleus 
this.Nucleus.setConcentration(this.Nucleus.ConcentrationRange, 3);

% set concentration for cellpie
% outside
setConcentration@fs.targets.Target(this, ...
    this.ConcentrationRange.Outside, 1);
% inside
setConcentration@fs.targets.Target(this.Inside, ...
    this.ConcentrationRange.Inside, 2);

% set concentration for cilium
if ~isempty(this.Cilium)
    setConcentration@fs.targets.Target(this.Cilium, ...
        [0.95, 1], 1, this.OutMask);
    setConcentration@fs.targets.Target(this.Cilium, [0.9, 1], 2);
end

end

