function [P,IP]=ionization_potential(Z,Level)
% Return ionization potential for elemnt and ionization level.
% Package: astro.spec
% Description: Returm the ionization potential for a given element and
%              ionization level.
% Input  : - Atomic number (Z) or name (e.g., 'He').
%          - Vector of ionization level. If empty (e.g., []), then will
%            return all the ionization potential available in the DB
%            for the specific element.
%            Default is empty matrix.
% Output : - List of ionization potentials [eV].
%          - Structure containing the entire database of ionization
%            potentials.
% Tested : Matlab 2012a
%     By : Eran O. Ofek                    Sep 2012
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Reference: http://srdata.nist.gov/gateway/gateway?dblist=0
%            http://www.physics.ohio-state.edu/~lvw/handyinfo/ips.html
% Example: [P,IP]=astro.spec.ionization_potential('He',2);
%          [P,IP]=astro.spec.ionization_potential(2,2);
%          [P,IP]=astro.spec.ionization_potential('Ti',[2 3]);
% Reliable: 2
%--------------------------------------------------------------------------

Def.Level = [];
if (nargin==1)
   Level = Def.Level;
elseif (nargin==2)
   % do nothing
else
   error('Illegal number of input arguments');
end


IP(1).P  = [13.598];
IP(1).N  = 'H';
IP(2).P  = [24.587 54.416];
IP(2).N  = 'He';
IP(3).P  = [5.392 75.638 122.451];
IP(3).N  = 'Li';
IP(4).P  = [9.322 18.211 153.893 217.713];
IP(4).N  = 'Be';
IP(5).P  = [8.298 25.154 37.930 259.368 340.217];
IP(5).N  = 'B';
IP(6).P  = [11.260 24.383 47.887 64.492 392.077 489.981];
IP(6).N  = 'C';
IP(7).P  = [14.534 29.601 47.448 77.472 97.888 552.057 667.029];
IP(7).N  = 'N';
IP(8).P  = [13.618 35.116 54.934 77.412 113.896 138.116 739.315 871.387];
IP(8).N  = 'O';
IP(9).P  = [17.422 34.970 62.707 87.138 114.240 157.161 185.182 953.886 1103.089];
IP(9).N  = 'F';
IP(10).P = [21.564 40.962 63.45 97.11 126.21 157.93 207.27 239.09 1195.797 1362.164];
IP(10).N  = 'Ne';
IP(11).P = [5.139 47.286 71.64 98.91 138.39 172.15 208.47 264.18 299.87 1465.091 1648.659];
IP(11).N  = 'Na';
IP(12).P = [7.646 15.035 80.143 109.24  141.26 186.50 224.94 265.90 327.95  367.53 1761.802 1962.613];
IP(12).N  = 'Mg';
IP(13).P = [5.986 18.828 28.447 119.99 153.71 190.47 241.43 284.59 330.21 398.57 442.07 2085.983 2304.080];
IP(13).N  = 'Al';
IP(14).P = [8.151 16.345 33.492 45.141 166.77 205.05 246.52 303.17 351.10 401.43 476.06 523.50 2437.676 2673.108];
IP(14).N  = 'Si';
IP(15).P = [10.486 19.725 30.18 51.37 65.023 230.43 263.22 309.41 371.73 424.50 479.57 560.41 611.85 2816.943 3069.762];
IP(15).N  = 'P';
IP(16).P = [10.360 23.33 34.83 47.30 72.68 88.049 280.93 328.23 379.10 447.09 504.78 564.65 651.63 707.14 3223.836 3494.099];
IP(16).N  = 'S';
IP(17).P = [12.967 23.81 39.61 53.46 67.8 98.03 114.193 348.28 400.05 455.62 529.26 591.97 656.69 749.74 809.39 3658.425 3946.193];
IP(17).N  = 'Cl';
IP(18).P = [15.759 27.629 40.74 59.81 75.02 91.007 124.319 143.456 422.44 478.68 538.95 618.24 686.09 755.73 854.75 918 4120.778 4426.114];
IP(18).N  = 'Ar';
IP(19).P = [4.341 31.625 45.72 60.91 82.66 100.0 117.56 154.86 175.814 503.44 564.13 629.09 714.02 787.13 861.77 968 1034 4610.955 4933.931];
IP(19).N  = 'K';
IP(20).P = [6.113 11.871 50.908 67.10 84.41 108.78 127.7 147.24 188.54 211.270  591.25 656.39 726.03 816.61 895.12 974 1087 1157 5129.045 5469.738];
IP(20).N  = 'Ca';
IP(21).P = [6.54 12.80 24.76 73.47 91.66 111.1 138.0 158.7 180.02 225.32 249.832 685.89 755.47 829.79 926.00];
IP(21).N  = 'Sc';
IP(22).P = [6.82 13.58 27.491 43.266 99.22 119.36 140.8 168.5 193.2 215.91 265.23 291.497 787.33 861.33 940.36];
IP(22).N  = 'Ti';
IP(23).P = [6.74 14.65 29.310 46.707 65.23 128.12 150.17 173.7 205.8 230.5 255.04 308.25 336.267 895.58 974.02];
IP(23).N  = 'V';
IP(24).P = [6.766 16.50 30.96 49.1 69.3 90.56 161.1 184.7 209.3 244.4 270.8 298.0 355 384.30 1010.64];
IP(24).N = 'Cr';
IP(25).P = [7.435 15.640 33.667 51.2 72.4 95 119.27 196.46 221.8 243.3 286.0 314.4 343.6 404 435.3 1136.2];
IP(25).N = 'Mn';
IP(26).P = [7.870 16.18 30.651 54.8 75.0 99 125 151.06 235.04 262.1 290.4 330.8 361.0 392.2 457 489.5 1266.1];
IP(26).N = 'Fe';
IP(27).P = [7.86 17.06 33.50 51.3 79.5 102 129 157 186.13 276 305 336 379 411 444 512 546.8 1403.0];
IP(27).N = 'Co';
IP(28).P = [7.635 18.168 35.17 54.9 75.5 108 133 162 193 224.5 321.2 352 384 430 464 499 571 607.2 1547];
IP(28).N = 'Ni';
IP(29).P = [7.726 20.292 36.83 55.2 79.9 103 139 166 199 232 266 368.8 401 435 484 520 557 633 671 1698];
IP(29).N = 'Cu';
IP(30).P = [9.394 17.964 39.722 59.4 82.6 108 134 174 203 238 274 310.8 419.7 454 490 542 579 619 698 738 1856];
IP(30).N = 'Zn';
IP(31).P = [5.999 20.51 30.71 64];
IP(31).N = 'Ga';
IP(32).P = [7.899 15.934 34.22 45.71 93.5];
IP(32).N = 'Ge';
IP(33).P = [9.81 18.633 28.351 50.13 62.63 127.6];
IP(33).N = 'As';
IP(34).P = [9.752 21.19 30.820 42.944 68.3 81.70 155.4];
IP(34).N = 'Se';
IP(35).P = [11.814 21.8 36 47.3 59.7 88.6 103.0 192.8];
IP(35).N = 'Br';
IP(36).P = [13.999 24.359 36.95 52.5 64.7 78.5 111.0 126 230.39];
IP(36).N = 'Kr';
IP(37).P = [4.177 27.28 40 52.6 71.0 84.4 99.2 136 150 277.1];
IP(37).N = 'Rb';
IP(38).P = [5.695 11.030 43.6 57 71.6 90.8 106 122.3 162 177 324.1];
IP(38).N = 'Sr';
IP(39).P = [6.38 12.24 20.52 61.8 77.0 93.0 116 129 146.52 191 206 374.0];
IP(39).N = 'Y';
IP(40).P = [6.84 13.13 22.99 34.34 81.5];
IP(40).N = 'Zr';
IP(41).P = [6.88 14.32 25.04 38.3 50.55 102.6 125];
IP(41).N = 'Nb';
IP(42).P = [7.099 16.15 27.16 46.4 61.2 68 126.8 153];
IP(42).N = 'Mo';
IP(43).P = [7.28 15.26 29.54];
IP(43).N = 'Te';
IP(44).P = [7.37 16.76 28.47];
IP(44).N = 'Ru';
IP(45).P = [7.46 18.08 31.06];
IP(45).N = 'Rh';
IP(46).P = [8.34 19.43 32.93];
IP(46).N = 'Pd';
IP(47).P = [7.576 21.49 34.83];
IP(47).N = 'Ag';



if (ischar(Z))
   Zind = find(strcmpi({IP.N},Z));
elseif (isnumeric(Z))
   Zind = Z;
else
   error('Unknown Z input type');
end


if (isempty(Level)) 
    P = IP(Zind).P;
else
    P = nan(numel(Zind),1);
    for Iz=1:1:numel(Zind)
        if ~(Zind(Iz)>numel(IP)) && ~isnan(Level(Iz))
            P(Iz) = IP(Zind(Iz)).P(Level(Iz));
        end
    end
end
