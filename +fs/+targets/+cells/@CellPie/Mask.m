function mask = Mask(this, side)
%CELLPIE::MASK ...
%   ...

% check input
narginchk(2, 2)
assert(ischar(side), '!! Input side must be a string.')

% get mask
if strcmp(side, 'inside')
    mask = this.Body(:, 3) <= this.Nucleus.ZRadius;
else
    mask = this.Body(:, 3) > this.Nucleus.ZRadius;
end


end

