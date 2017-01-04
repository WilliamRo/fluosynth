function align(this)
%CILIUM::ALIGN ...
%   ...

% call TARGET::ALIGN
ofst = align@fs.targets.Target(this);

% move initial points
num = size(this.InitPoints, 1);
this.InitPoints = this.InitPoints + repmat(ofst, num, 1);

end

