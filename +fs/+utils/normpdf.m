function y = normpdf(x, mu, sigma)
%NORMPDF ...
%   ...

y = (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2/(2*sigma*sigma));

end

