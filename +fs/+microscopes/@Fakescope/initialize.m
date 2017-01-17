function initialize(this)
%FAKESCOPE::INITIALIZE ...
%   ...

len = length(this.SpreadSigmas);
this.Spreads = cell(len, 1);
for i = 1 : len, this.Spreads{i} = fs.utils.spread(...
        this.SpreadSize, this.SpreadSigmas(i));
end % for i 

end

