function cursorChanged(this, ~, ~)
%PROGRESSBAR::CURSORCHANGED ...
%   ...

% backspace
this.backspace();

% part 1
totalStr = num2str(this.Total);
str = ['%', num2str(length(totalStr)), 'd/', totalStr];
part1 = sprintf(str, this.Cursor);

% part 2
part2 = this.Bar;

% part 3

if this.Cursor == 0
    part3 = 'ETA: -- sec';
else
    timespan = toc(this.StartTime);
    if ~this.Finished
        % calculate ETA
        eta = this.Total * timespan / this.Cursor - timespan;
        part3 = sprintf('ETA: %.1f sec', eta);
    else
        part3 = sprintf('%.1f sec', timespan);
    end
end

% combine output string
output = sprintf('%s %s - %s', part1, part2, part3);
this.BackCount = length(output);

% print
fprintf(output);
if this.Finished, fprintf('\n'); end

end

