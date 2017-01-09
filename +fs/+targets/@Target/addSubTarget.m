function addSubTarget(this, target, position)
%TARGET::ADDSUBTARGET adds a subtarget to THIS
%   ...

% check input
assert(length(position) == size(position, 2), ...
    '!! Input position is illegal.')

% add subtarget and set position
this.SubTargets = [this.SubTargets, target];
target.setPosition(position);

end

