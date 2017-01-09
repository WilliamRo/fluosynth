function ofst = Offset(this)
%TARGET::OFFSET returns offsets for each point in this.Body
%   ...

ofst = this.Position - this.BasePoint;

end

