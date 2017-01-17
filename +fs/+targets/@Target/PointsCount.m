function count = PointsCount(this)
%TARGET::POINTSCOUNT ...
%   ...

targets = this.AllMembers;
count = 0;
for i = 1 : length(targets)
    count = count + size(targets{i}.Body, 1);
end

end

