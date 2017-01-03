function interpolate(this)
%CILIUM::INTERPOLATE ...
%   ...

% basic configuration
tt_len = 200;

% check input
assert(size(this.InitPoints, 2) == 3)

% interpolate 
tt = linspace(0, 1, tt_len);
p = fs.utils.spline(this.InitPointsDistr, ...
                    this.InitPoints, tt);
                
% calculate curve length
len = 0;
for i = 2 : tt_len
    len = len + norm(p(i, :) - p(i-1, :));
end
this.Length = len;

% undersample curve
len = floor(len);
tt = linspace(0, 1, len);
this.Body = fs.utils.spline(this.InitPointsDistr, ...
                            this.InitPoints, tt);

end

