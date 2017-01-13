function backspace(this)
%PROGRESSBAR::BACKSPACE ...
%   ...

% for i = 1 : this.BackCount, fprintf('\b'); end
fprintf(repmat(sprintf('\b'), 1, this.BackCount))
this.BackCount = 0;

end

