classdef ProgressBar < handle
    %PROGRESSBAR ...
    %   ...
    %% Constants
    properties (Constant, Access = private)
        BarLength = 20
    end
    %% Private Properties
    properties (Access = private, SetObservable)
        Total
        Cursor
        BackCount = 0
        StartTime
    end
    %% Public Methods
    methods (Access = public)
        %% Constructor
        function this = ProgressBar
            addlistener(this, 'Cursor', 'PostSet', ...
                @this.cursorChanged);
        end
        initialize(this, total)
        moveCursor(this, cursor)
        finish(this)
    end
    %% Private Methods
    methods (Access = private)
        cursorChanged(this, metaProp, eventData)
        backspace(this)
        % Property Methods
        bar = Bar(this)
        function flag = Finished(this)
            flag = this.Cursor == this.Total;
        end
    end
    
end

