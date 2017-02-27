function viewData(this)
%DATAVIEWER::VIEWDATA ...
%   ...

%% Check properties of this
% ...

%% Set figure and axes
pct = 0.4;  corner = (1 - pct) / 2;
% open a new figure
f = figure('Name', this.FigureName, 'NumberTitle', 'off', ...
    'ToolBar', 'none', 'MenuBar', 'none', 'Units', 'normalized', ...
    'Resize', 'on', 'Position', [corner corner pct pct], ...
    'Color', [1 1 1]);
f.Units = 'pixels';
fSize = min(f.Position(3:4));
f.Position = [f.Position(1:2), fSize, fSize];
f.KeyPressFcn = @btnPressed;
f.UserData = this;
% set new axes
ax = axes('Units', 'normalized', 'Position', [0 0 1 1], ...
    'NextPlot', 'replace');

%% Show data
this.Cursor = 1;

%% Callback functions
    function btnPressed(f, callbackdata)
        % set parameters
        sizeStep = 20;  % pixels
        delta = [-sizeStep/2, -sizeStep/2, sizeStep, sizeStep];
        % ...
        switch lower(callbackdata.Key)
            case {'leftarrow', 'h'}
                f.UserData.Cursor = f.UserData.Cursor - 1;
            case {'rightarrow', 'l'}
                f.UserData.Cursor = f.UserData.Cursor + 1;
            case {'uparrow', 'k', 'add'}
                f.Position = f.Position + delta;
            case {'downarrow', 'j', 'subtract'}
                f.Position = f.Position - delta;
            case {'escape', 'return'}
                close(f)
            otherwise
                fprintf('>> Unknown key pressed: [%s]\n', ...
                    callbackdata.Key)
        end
    end

end