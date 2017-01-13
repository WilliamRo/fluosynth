function count = TotalTargetsCount(this, channel)
%SPECIMEN::TOTALTARGETSCOUNT ...
%   ...

count = 0;
for i = 1 : length(this.Targets)
    targets = this.Targets{i}.AllMembers;
    for k = 1 : length(targets)
        target = targets{k};
        if ~target.checkChannel(channel), continue; end
        count = count + size(target.Body, 1);
    end
end

end

