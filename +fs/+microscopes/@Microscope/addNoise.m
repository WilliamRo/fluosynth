function image = addNoise(this, image)
%MICROSCOPE::ADDNOISE ...
%   ...

% check input
narginchk(2, 2)

% add noise
ntypes = fieldnames(this.NoiseParams);
for i = 1 : length(ntypes)
    ntype = ntypes{i};
    param = this.NoiseParams.(ntype);
    switch ntype
        case 'gaussian'
            if isempty(param), param = {0.001}; end
            image = imnoise(image, 'gaussian', 0, param{:});
        case 'poisson'
            image = imnoise(image, 'poisson');
        otherwise
            try
                image = imnoise(image, ntype, param{:});
            catch
                warning('Unknow noise type: %s', ntype)
            end
    end
end

end

