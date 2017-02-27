function stacktable = stack2table(stack, labels)
%STACK2TABLE ...
%   ...

% check inputs
narginchk(2, 2)
assert(min(size(labels, 1), size(labels, 2)) == 1, ...
    '!! Input labels are illegal.')

% generate table
N = length(labels);
M = size(stack, 1) * size(stack, 2);
roitable = zeros(N, M + 1);
for i = 1 : N
    roitable(i, 1:end-1) = reshape(stack(:, :, i), 1, M);
    roitable(i, end) = labels(i);
end
stacktable = array2table(roitable);

end

