function initialize(this)
%SPECIMEN::INITIALIZE ...
%   ... 

this.Distribution = cell(1, this.ChannelNum);
for i = 1 : this.ChannelNum
    this.Distribution{i} = zeros(this.Shape, 'single');
end

end

