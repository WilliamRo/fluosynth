function initProgress(this, channel, total)
%MICROSCOPE::INITPROGRESS ...
%   ...

% check input
if nargin < 3, total = this.Specimen.TotalTargetsCount(channel); end

% initialize progress
fprintf('>> Synthesizing Channel %s ...\n', ...
    fs.LabBench.ChannelNames{channel});
this.ProgressBar.initialize(total)

end

