function interpolate(this)
%CILIUM::INTERPOLATE ...
%   ...

% check input
assert(size(this.InitPoints, 2) == 3)

% get curve length 
[~, len] = fs.utils.spline(this.InitPointsDistr, ...
                           this.InitPoints);
this.Length = len;

% undersample curve
len = floor(len);
tt = linspace(0, 1, len);
this.Body = fs.utils.spline(this.InitPointsDistr, ...
                            this.InitPoints, tt);

end

