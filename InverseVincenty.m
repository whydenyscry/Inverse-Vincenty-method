function [d, alpha] = InverseVincenty(lat1, lon1, lat2, lon2)
%% INPUT DEGREES:
% latA = 50.242222;
% lonA = 36.984722;
% latB = 50.406667;
% lonB = 36.881389;
% InverseVincenty(latA,lonA,latB,lonB)
%%

lat1 = lat1 * pi/180;
lat2 = lat2 * pi/180;
lon1 = lon1 * pi/180;
lon2 = lon2 * pi/180;

a = 6378137;
f = 1 / 298.257223563;
b = a*(1-f);
L = lon2 - lon1;
U1 = atan((1 - f) * tan(lat1));
U2 = atan((1 - f) * tan(lat2));

sin_U1 = sin(U1);
cos_U1 = cos(U1);
sin_U2 = sin(U2);
cos_U2 = cos(U2);

lambda(1) = L;
done = false;
eps = 1e-12;
k = 1;
iterLimit = 100;

while ~done
    sin_Lambda = sin(lambda(k));
    cos_Lambda = cos(lambda(k));

    sin_Sigma = sqrt((cos_U2 * sin_Lambda) ^ 2 + (cos_U1 * sin_U2 - sin_U1 * cos_U2 * cos_Lambda) ^ 2);
    cos_Sigma = sin_U1 * sin_U2 + cos_U1 * cos_U2 * cos_Lambda;

    sigma = atan2(sin_Sigma, cos_Sigma);
    sin_Alpha = cos_U1 * cos_U2 * sin_Lambda / sin_Sigma;
    cosSq_Alpha = 1 - sin_Alpha^2;
    cos_2SigmaM = cos_Sigma - 2 * sin_U1 * sin_U2 / cosSq_Alpha;

    C = f / 16 * cosSq_Alpha * (4 + f * (4 - 3 * cosSq_Alpha));

    lambda(k+1) = L + (1 - C) * f * sin_Alpha * (sigma + C * sin_Sigma * (cos_2SigmaM + C * cos_Sigma * (-1 + 2 * cos_2SigmaM^2)));

    if  abs(lambda(k+1) - lambda(k))<=eps || iterLimit==0
        done = true;
        sin_Lambda = sin(lambda(k+1));
        cos_Lambda = cos(lambda(k+1));
    else
        k = k + 1;
        iterLimit = iterLimit - 1;
    end 
end

uSq = cosSq_Alpha * (a ^ 2 - b ^ 2) / (b ^ 2);

% A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
% B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));

F = (sqrt(1 + uSq) - 1 ) / (sqrt(1 + uSq) + 1);
A = (1 + 1 / 4 * F ^ 2) / (1 - F);
B = F * (1 - 3 / 8 * F ^ 2);

deltaSigma = B * sin_Sigma * (cos_2SigmaM + B / 4 * (cos_Sigma * (-1 + 2 * cos_2SigmaM^2) - B / 6 * cos_2SigmaM * (-3 + 4 * sin_Sigma^2) * (-3 + 4 * cos_2SigmaM^2)));

if iterLimit==0
    warning("The iteration limit has been reached!")
end

d = b * A * (sigma - deltaSigma);

alpha(1) = atan2(cos_U2 * sin_Lambda, cos_U1 * sin_U2 - sin_U1 * cos_U2 * cos_Lambda);
alpha(2) = atan2(cos_U1 * sin_Lambda, cos_U1 * sin_U2 * cos_Lambda - sin_U1 * cos_U2);
end