function addTarget(this, target, position, channel)
%SPECIMEN::ADDTARGET ...
%   ...

% check input
narginchk(2, 4)
assert(isa(target, 'fs.targets.Target'), ...
       '!! The input target is illegal.')
if nargin < 4, channel = 1; end
this.channelIndexCheck(channel)
[zl, zh] = target.Margin;
if nargin < 3 || isempty(position)
    position = rand(1, 3) .* this.Shape;
    [zmin, zmax] = deal(1 + zl, this.Shape(3) - zh);
    position(3) = rand * (zmax - zmin) + zmin;
end

% check z position
z = position(3);
if z + zh > this.Shape(3) || z - zl < 1
    warning('Target out of bound!!')
end

% add target to specimen
index = length(this.Targets) + 1;
this.Targets(index).target = target;
this.Targets(index).position = position;
this.Targets(index).offset = position - target.BasePoint;

end

