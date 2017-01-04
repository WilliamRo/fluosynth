function setConcentration(this, pct)
%TARGET::SETCONCENTRATION ...
%   ...

% check input
if nargin < 2, pct = [0.95, 1]; end
assert(all(and(pct >= 0, pct <= 1)), ...
       '!! Illegal concentration.')

% set concentration
num = size(this.Body, 1);
for i = 1 : num
    this.Concentration(i) = ...
         fs.utils.truncated_randn(pct);
end

end

