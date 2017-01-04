function varargout = align(this)
%TARGET::ALIGN ...
%   ...

% check input
assert(~isempty(this.Body), 'Body is empty')

% calculate ofst
ofst = zeros(1, 3);
for i = 1 : 3
    ofst(i) = -min(this.Body(:, i));
end

% align
num = size(this.Body, 1);
this.Body = this.Body + repmat(ofst, num, 1);

% output
if nargout > 0, varargout{1} = ofst; end

end

