function name = ClassName(this)
%TARGET::CLASSNAME ...
%   ...

splits = strsplit(getfield(metaclass(this), 'Name'), '.');
name = splits{end};

end

