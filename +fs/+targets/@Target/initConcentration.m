function initConcentration(this)
%TARGET::INITCONCENTRATION ...
%   ...

assert(~isempty(this.Body), '!!Body is empty')

num = size(this.Body, 1);
this.Concentration = zeros(num, 1);

end

