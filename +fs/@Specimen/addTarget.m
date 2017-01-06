function addTarget(this, target, position, channel)
%SPECIMEN::ADDTARGET ...
%   ...

% check input
narginchk(2, 4)
assert(isa(target, 'fs.targets.Target'), ...
       '!! The input target is illegal.')
if nargin < 4, channel = 1; end
this.channelIndexCheck(channel)
if nargin < 3 || isempty(position)
    position = rand(1, 3) .* this.Shape;
end

% add target to specimen
index = length(this.Channels(channel).targets) + 1;
this.Channels(channel).targets(index) ...
                      .target = target;
this.Channels(channel).targets(index) ...
                      .position = position;

end

