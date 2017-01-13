function moveCursor(this, cursor)
%PROGRESSBAR::MOVECURSOR ...
%   ...

% check input
narginchk(2, 2)
assert(cursor == fix(cursor) && cursor >= 0, ...
    '!! Cursor must be a non-negtive integer.')
assert(cursor >= this.Cursor, '!! Cursor is moving backward.')

% set cursor
this.Cursor = cursor;

end

