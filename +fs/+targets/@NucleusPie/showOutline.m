function showOutline(this)
%NUCLEUS::SHOWOUTLINE ...
%   ...

% config
max_rad = 100;

% select figure
figure(fs.config.FigureIDs.target), clf, hold on

% show outline
outline = [this.Outline; this.Outline(1, :)];
plot(outline(:, 1), outline(:, 2), '-', 'color', this.Color)
for i = 1 : size(this.InitPoints, 1)
    text(this.InitPoints(i, 1), this.InitPoints(i, 2), ...
        num2str(i), 'color', 'Red')
end
% plot(this.InitPoints(:, 1), this.InitPoints(:, 2), 'ro')
xlim([-max_rad, max_rad]), ylim([-max_rad, max_rad])
xlabel('X Axis'), ylabel('Y Axis')
title('Outline')

end

