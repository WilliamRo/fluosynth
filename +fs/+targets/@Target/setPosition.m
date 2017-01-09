function setPosition(this, position)
%TARGET::SETPOTISION sets position for THIS
%   ...

% check input
narginchk(2, 2)
assert(size(position, 2) == length(position), ...
       '!! Input position is illegal.')
   
% set position
ofst = position - this.Position;
this.Position = position;

% set position to subtargets
for i = 1 : length(this.SubTargets)
    p = this.SubTargets{i}.Position + ofst;
    this.SubTargets{i}.setPosition(p);
end

end

