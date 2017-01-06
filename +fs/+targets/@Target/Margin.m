function [zl, zh] = Margin(this)
%TARGET::MARGIN ...
%   ...

b = this.BasePoint;
zl = b(3) - 1;
zh = max(this.Body(:, 3)) - b(3);

end

