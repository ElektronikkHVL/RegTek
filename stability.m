function G = stability(numerator, denominator, min_value, max_value, antall);

G = tf(numerator,denominator);

if ~exist('antall', 'var')
    antall = 500;
end

if ~exist('min_value', 'var') && ~exist('max_value', 'var')
    bode(G)
else
    bode(G,logspace(min_value,max_value,antall))
end

margin(G)
grid on
end