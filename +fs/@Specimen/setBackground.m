function setBackground(this, concentration, channel)
%SPECIMEN::SETBACKGROUND sets the background fluorophore 
%   concentration for a specific channel
%
%   SYNTAX: spe.setBackground(concentration, channel)

% check input
narginchk(2, 3)
assert(all(concentration >= 0, concentration <= 1), ...
       '!! Input concentration is illegal')
if nargin < 3, channel = 1; end
this.channelIndexCheck(channel)

% set background concentration
this.Channels(channel).background = concentration;

end

