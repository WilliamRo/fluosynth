function setConcentration(this, pct, col, part)
%TARGET::SETCONCENTRATION ...
%   ...

% check input
if nargin < 4, part = 1 : size(this.Body, 1); end
if nargin < 3, col = 1; end
if nargin < 2, pct = [0.95, 1]; end
assert(all(and(pct >= 0, pct <= 1)), ...
       '!! Illegal concentration.')

% set concentration
for i = 1 : part
    this.Concentration(i, col) = ...
         fs.utils.truncated_randn(pct);
end

end

