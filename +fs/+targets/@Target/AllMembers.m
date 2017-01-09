function targets = AllMembers(this)
%TARGET::ALLMEMBERS returns all THIS and all its subtargets
%   ...

targets = {this};
for i = 1 : length(this.SubTargets)
    targets = [targets, this.SubTargets{i}.AllMembers];
end

end

