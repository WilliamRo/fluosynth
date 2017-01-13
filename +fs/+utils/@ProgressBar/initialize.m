function initialize(this, total)
%PROGRESSBAR::INITIALIZE ...
%   ...

% check input
narginchk(2, 2)
assert(total == fix(total) && total > 0, ...
    '!! Variable ''total'' must be a positive integer.')

% set total and reset cursor ...
this.Total = total;
this.BackCount = 0;
this.Cursor = 0;

% start stopwatch
this.StartTime = tic;

end

