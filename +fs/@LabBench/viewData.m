function viewData(stack, labels, type)
%...
%   ...

% check input
if nargin < 3, type = 'flag'; end
switch lower(type)
    case 'false'
        interpreter = @fs.DataViewer.tnf;
    case 'flag'
        interpreter = @fs.DataViewer.tof;
    otherwise
        interpreter = @fs.DataViewer.empt;
end

% view data
dv = fs.DataViewer(stack, labels, interpreter);
dv.viewData;

end

