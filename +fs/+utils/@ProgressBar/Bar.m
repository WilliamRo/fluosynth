function bar = Bar(this)
%PROGRESSBAR::BAR ...
%   ...

% calculate front index
index = max(1, round(this.BarLength * this.Cursor / this.Total));

% generate bar
if ~this.Finished, [left, middle] = deal(index - 1, 1);
else [left, middle] = deal(index, 0); end
right = this.BarLength - left - middle;
bar = ['[', repmat('=', 1, left), ...
            repmat('>', 1, middle), ...
            repmat('.', 1, right), ']'];
end

