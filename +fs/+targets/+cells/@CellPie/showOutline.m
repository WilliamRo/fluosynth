function showOutline(this)
%CELLPIE::SHOWOUTLINE ...
%   ...

% check input
assert(~isempty(this.Nucleus), '!! Necleus not detected.')

% show nucleus outline
this.Nucleus.showOutline();

% show outline
%

% show vertexes and pits
%

% limit axis
rad = this.Nucleus.MaxAspectRatio * this.Nucleus.DefaultMinor * ...
    this.DefaultParams.SpokeRange(2) + 20;
xlim([-rad, rad]), ylim([-rad, rad])

end

