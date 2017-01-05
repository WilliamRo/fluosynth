function flag = inbound(this, coord)
%SPECIMEN::UNTITLED ...
%   ...

% check input
narginchk(2, 2)

% check inbound
flag = and(all(coord > 0), ...
           all(coord - this.Shape <= 0));

end

