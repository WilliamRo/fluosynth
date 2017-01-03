function index = roll
%CILIUM::ROLL ...
%   ...

% get weights
templates = fs.targets.Cilium.Templates;
cnt = size(templates, 1);
weights = cell(1, cnt);
[weights{:}] = deal(templates{:, 2});
weights = cell2mat(weights);
weights = weights / sum(weights);

% roll
index = 1;
r = rand - weights(index);
while r > 0 && index < cnt
    index = index + 1; 
    r = r - weights(index);
end

end

