function [Lon,Lat,Rad,HP]=moonecool(Date)
% Low-accuracy geocentric ecliptical coordinate of the Moon
% Package: celestial.SolarSys
% Description: Calculate low accuracy geocentric ecliptical coordinates
%              of the Moon, referred to the mean equinox of date.
%              Accuracy: in longitude and latitude ~1', distance ~50km
%              To get apparent longitude add nutation in longitude.
% Input  : - matrix od dates, [D M Y frac_day] per line,
%            or JD per line. In TT time scale.
% Output : - Longitude [radians].
%          - Latitude [radians].
%          - radis vector [km]
%          - HP [radians].
% See Also: mooncool.m
% Tested : Matlab 5.3
%     By : Eran O. Ofek                    Aug 1999
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Eaxmple: [Lon,Lat,Rad,HP]=celestial.SolarSys.moonecool(2451545+(0:1:10)')
% Reliable: 2
%--------------------------------------------------------------------------

RAD = 180./pi;

FunTPI = @(X) (X./(2.*pi) - floor(X./(2.*pi))).*2.*pi;

SizeDate = size(Date);
N        = SizeDate(1);
ColN     = SizeDate(2);

if (ColN==4),
   JD = celestial.time.julday(Date).';
elseif (ColN==1),
   JD = Date;
else
   error('Illigal number of columns in date matrix');
end

T = (JD - 2451545)./36525.0;

% Moon's mean longitude (equinox of date + light term)
Lt = 218.3164591 + 481267.88134236.*T -...
                        0.0013268.*T.^2 + ...
                   T.^3./538841 -...
                   T.^4./65194000;
              
% Mean elongation of the Moon
D  = 297.8502042 + 445267.1115168.*T - ...
                        0.0016300.*T.^2 + ...
                   T.^3./545868 - ...
                   T.^4./113065000;
              
% Sun's mean anomaly
M  = 357.5291092 + 35999.0502909.*T - ...
                       0.0001536.*T.^2 + ...
                   T.^3./24490000;

% Moon's mean anomaly
Mt = 134.9634114 + 477198.8676313.*T + ...
                        0.0089970.*T.^2 + ...
                   T.^3./69699 + ...
                   T.^4./14712000;

% Moon's argument of latitude
F  = 93.2720993 + 483202.0175273.*T -...
                       0.0034029.*T.^2 -...
                  T.^3./3526000 +...
                  T.^4./863310000;

% Earth eccentricity
E  = 1 - 0.002516.*T - 0.0000074.*T.^2;


% convert to radians
Lt = Lt./RAD;
D  = D./RAD;
M  = M./RAD;
Mt = Mt./RAD;
F  = F./RAD;

% convert to 0-2\pi
Lt = FunTPI(Lt);
D  = FunTPI(D);
M  = FunTPI(M);
Mt = FunTPI(Mt);
F  = FunTPI(F);

SumL = 6288774.*sin(Mt) +...
     1274027.*sin(2.*D - Mt) +...
     658314.*sin(2.*D) +...
     213618.*sin(2.*Mt) -...
     185116.*sin(M).*E -...
     114332.*sin(2.*F) +...
     58793.*sin(2.*D - 2.*Mt) +...
     57066.*sin(2.*D - M - Mt).*E +...
     53322.*sin(2.*D + Mt) +...
     45758.*sin(2.*D - M).*E -...
     40923.*sin(M - Mt).*E -...
     34720.*sin(D) -...
     30383.*sin(M + Mt).*E +...
     15327.*sin(2.*D - 2.*F) -...
     12528.*sin(Mt + 2.*F) +...
     10980.*sin(Mt - 2.*F) +...
     10675.*sin(4.*D - Mt) +...
     10034.*sin(Mt) +...
     8548.*sin(4.*D - 2.*Mt) -...
     7888.*sin(2.*D + M - Mt).*E -...
     6766.*sin(2.*D + M).*E -...
     5163.*sin(D - Mt);

SumR = -20905355.*cos(Mt) ...
     -3699111.*cos(2.*D - Mt) ...
     -2955968.*cos(2.*D) ...
     -569925.*cos(2.*Mt) ...
     +48888.*cos(M).*E ...
     -3149.*cos(2.*F) ...
     +246158.*cos(2.*D - 2.*Mt) ...
     -152138.*cos(2.*D - M - Mt).*E ...
     -170733.*cos(2.*D + Mt) ...
     -204586.*cos(2.*D - M).*E ...
     -129620.*cos(M - Mt).*E ...
     +108743.*cos(D) ...
     +104755.*cos(M + Mt).*E ...
     +10321.*cos(2.*D - 2.*F) ...
     +0.*cos(Mt + 2.*F) ...
     +79661.*cos(Mt - 2.*F) ...
     -34782.*cos(4.*D - Mt) ...
     -23210.*cos(Mt) ...
     -21636.*cos(4.*D - 2.*Mt) ...
     +24208.*cos(2.*D + M - Mt).*E ...
     +30824.*cos(2.*D + M).*E ...
     -8379.*cos(D - Mt);
  
  
  SumB = 5128122.*sin(F) ...
     +280602.*sin(Mt + F) ...
     +277693.*sin(Mt - F) ...
     +173237.*sin(2.*D - F) ...
     +55413.*sin(2.*D - Mt + F) ...
     +46271.*sin(2.*D - Mt - F) ...
     +32573.*sin(2.*D + F) ...
     +17198.*sin(2.*Mt + F) ...
     +9266.*sin(2.*D + Mt - F) ...
     +8822.*sin(2.*Mt - F) ...
     +8216.*sin(2.*D - M - F).*E;

Lon   = Lt + SumL.*1e-6./RAD;
Lat   = SumB.*1e-6./RAD;
Rad   = 385000.56 + SumR.*1e-3;
HP    = asin(6378.14./Rad);


