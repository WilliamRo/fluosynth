function initialize(this)
%CELLPIE::INITIALIZE ...
%   ...

%% check input, get nucleus information
assert(~isempty(this.Nucleus), '!! Necleus not detected.')
nucleus = this.Nucleus;
len = size(nucleus.Outline, 1);

%% generate vertexes and pits
vertex_num = randi(this.DefaultParams.VertexRange);


end

%%
% len = size(nucleus.Outline, 1);
% given theta: index = round((len-1)*theta/(2*pi)+1)
%              coord = nucleus.Outline(index, :)
