function coords = Coordinate(this)
%TARGET::COORDINATE returns coordinate of THIS
%   ...

ofst = repmat(this.Offset, size(this.Body, 1), 1);
coords = this.Body + ofst;

end

