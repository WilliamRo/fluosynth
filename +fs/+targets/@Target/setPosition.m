function setPosition(this, position)
%TARGET::SETPOTISION sets position for THIS
%   ...

% check input
narginchk(2, 2)
assert(size(position, 2) == length(position), ...
       '!! Input position is illegal.')
   
% set position
this.Position = position;

end

