function cilium = getTemplate(index, len, transform)
%CILIUM::GETTEMPLATE ...
%   Example:
%          c = fs.targets.Cilium.getTemplate;
%
%     To get the template indexed 1:
%          c = fs.targets.Cilium.getTemplate(1);
%
%     To get a random template with length 35:
%          c = fs.targets.Cilium.getTemplate([], 35);
%
%     To get a randomly transformed random template:
%          len = fs.utils.truncated_randn(bounds, mid);
%          c = fs.targets.Cilium.getTemplate([], [], true);

% check input
if nargin < 3, transform = false; end
if nargin < 1 || isempty(index)
   index = fs.targets.Cilium.roll;
end
total = size(fs.targets.Cilium.Templates, 1);
assert(index >= 1 && index <= total, ...
       'Index out of bound')

% get template
datapoints = fs.targets.Cilium.Templates{index, 1};

% transform
if transform
    [I, J] = size(datapoints);
    delta = fs.targets.Cilium.Templates{index, 3};
    datapoints = datapoints + randn(I, J) .* delta;
end

% adjust scale
if nargin > 1 && ~isempty(len)
    [~, L] = fs.utils.spline([], datapoints);
    datapoints = datapoints / L * len;
end
distr = datapoints(:, 1);
cilium = fs.targets.Cilium(datapoints, 't', distr);

end

