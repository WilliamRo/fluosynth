classdef DataViewer < handle
    %DATAVIEWER ...
    %   ...
    %% Constants
    properties (Access = private, Constant)
        FigureName = 'Date Viewer';
    end
    %% Private Properties
    properties (Access = private, SetObservable)
        Data
        Profiles
        Interpreter
        Cursor
    end
    %% Public Methods
    methods (Access = public)
        % Constructor
        function this = DataViewer(data, profiles, interpreter)
            % check input
            narginchk(1, 3)
            assert(~isempty(data), '!! Input data is illegal.')
            % set parameters
            this.Cursor = 1;
            this.Data = data;
            if nargin > 2, this.Profiles = profiles; 
                this.Interpreter = interpreter; end
            addlistener(this, 'Cursor', 'PostSet', ...
                @this.cursorChanged);
        end % constructor
        %
        viewData(this)
    end
    %% Private Methods
    methods (Access = private)
        setParams(this, varargin)
        function cursorChanged(this, ~, ~)
            if this.Cursor == 0, this.Cursor = 1;
            elseif this.Cursor > size(this.Data, 3)
                this.Cursor = size(this.Data, 3);
            else
                imshow(this.Data(:, :, this.Cursor), []); 
                f = gcf;
                f.Name = sprintf('[%d/%d] %s - %s', ...
                    this.Cursor, size(this.Data, 3), ...
                    this.Interpreter(this.Profiles(this.Cursor)), ...
                    this.FigureName);
            end
        end
    end
    %% Static Methods
    methods (Static, Access = public)
        function str = empt(idx)
            str = '';
        end % tnf
        function str = tof(idx)
            dicts = {'False', 'True'};
            str = dicts{idx + 1};
        end % tnf
        function str = tnf(idx)
            dicts = {'False', 'True'};
            str = sprintf('%s => %s', dicts{idx+1}, dicts{2-idx});
        end % tnf
    end % Static Methods
    
end

