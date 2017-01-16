function distr = DistrAlongSpoke(this, count, varargin)
%CELLPIE::DISTRALONGSPOKE ...
%   ...

%% check input
assert(count == fix(count) && count > 0, ...
    '!! Input count must be a positive integer!')
if ~isempty(find(strcmp(varargin, 'inside'), 1)),
    fieldName = 'Inside';
else fieldName = 'Outside'; 
end
len = this.DefaultParams.('DistrPointsCount');

%% check variable pool
if isempty(this.VariablePool.(fieldName))
    params = this.DefaultParams.(fieldName);
    [altitude, sigma] = deal(params(1), params(2));
    x = linspace(0, 1, len);
    y = (altitude - 1) * exp(-(x .^ 2) / (2 * sigma ^ 2)) + 1;
    y = len * y / sum(y);
    if strcmp(fieldName, 'Outside'), y = y(end:-1:1); end
    accu = zeros(1, len);  accu(1) = y(1);
    for i = 2 : len, accu(i) = accu(i - 1) + y(i); end
    tt = 0 : (len - 1);
    F = interp1(accu, x, tt)';
    this.VariablePool.(fieldName) = F;
else F = this.VariablePool.(fieldName);
end

%% get rand
indices = max(1, round(sqrt(rand(count, 1)) * len));
distr = F(indices);

end

