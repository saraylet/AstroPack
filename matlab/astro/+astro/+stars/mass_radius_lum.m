function MassRadius=mass_radius_lum
    % Return the mass-radius-effective T, logg, Lum, for the main sequence
    % Input  : null
    % Output : - A Table with the mass, radius, logg, T, etc. for main
    %            sequence stars.
    % Reference: Eker et al. (2018) https://academic.oup.com/mnras/article/479/4/5491/5056185
    % Author : Eran Ofek (Oct 2023)
    % Example: Table=astro.stars.mass_radius_lum

Table=   [0.16    0.25      6      0.217    0.238     3105     5.02    {'M4.5'}    10.55    45.771    0.044
    0.25    0.35      5      0.281    0.302     3167    4.926    {'M3.5'}     9.95    34.075    0.057
    0.35    0.45     11      0.398    0.395     3282    4.844    {'M3'  }     9.21    24.434     0.08
    0.45    0.55     12      0.503    0.489     3547    4.761    {'M1.5'}     8.41    14.804     0.13
    0.55    0.65     11      0.602    0.612     3924    4.644    {'K9'  }     7.49    7.5421     0.26
    0.65    0.75     14       0.69    0.675     4289    4.618    {'K4.5'}     6.89    4.9844     0.39
    0.75    0.85     14      0.802    0.798     4663    4.539    {'K3.5'}     6.16    2.9687     0.65
    0.85    0.95     19      0.907    0.935     5279    4.454    {'K0'  }     5.28    1.4882      1.3
    0.95    1.05     18          1    1.092     5498    4.362    {'G5'  }     4.76    1.0222     1.89
    1.05    1.15     21      1.093    1.176     5922    4.336    {'G3'  }     4.28    0.7156      2.7
    1.15    1.25     22      1.209    1.337     6181    4.269    {'F8'  }     3.82    0.5162     3.74
    1.25    1.35     43        1.3    1.482     6396    4.211    {'F6'  }     3.44    0.3941     4.91
    1.35    1.45     27      1.398    1.688     6495    4.129    {'F4.5'}     3.09     0.307      6.3
    1.45    1.55     23      1.502    1.823     6737    4.093    {'F3'  }     2.77    0.2443     7.91
    1.55    1.65     25      1.596    1.865     7110      4.1    {'F1'  }     2.49    0.2001     9.66
    1.65    1.75     12      1.702    1.818     7794     4.15    {'A8'  }     2.14    0.1554       12
    1.75    1.85     22      1.793     2.23     7560    3.995    {'A6'  }     1.83     0.123       16
    1.85    1.95     18      1.894    2.035     8153    4.099    {'A5'  }      1.7    0.1153       17
    1.95    2.05     19      1.994    2.059     8606    4.111    {'A4'  }     1.44    0.0955       20
    2.05     2.2     17      2.139    2.353     8722    4.025    {'A3'  }     1.09    0.0744       26
     2.2     2.4     26      2.299    2.683     9154    3.943    {'A2'  }      0.6    0.0507       38
     2.4     2.8     20      2.573    2.653    10030    4.001    {'A0'  }     0.22    0.0402       48
     2.8     3.2     10      2.993     2.61    10999    4.081    {'B9'  }      NaN    0.0335       58
     3.2     3.6     12      3.362    2.657    12239    4.116    {'B8'  }      NaN    0.0236       82
     3.6       4      8      3.769    3.497    12588    3.927    {'B7.5'}      NaN    0.0137      141
       4     4.6      8       4.31    2.911    15372    4.145    {'B5.5'}      NaN    0.0101      190
     4.6     5.2      9      4.916    3.287    16576    4.096    {'B4.5'}      NaN    0.0067      288
     5.2       6      8      5.587    3.797    17677    4.027    {'B3.5'}      NaN    0.0044      437
       6       8      7      6.716     4.46    19729    3.967    {'B2.5'}      NaN    0.0025      779
       8      10      7      9.083    4.488    25057    4.092    {'B2'  }      NaN    0.0013     1516
      10      12     11     11.143    5.497    26685    4.005    {'B1'  }      NaN    0.0008     2386
      12      15      8     13.702    6.186    28583    3.992    {'B0.5'}      NaN    0.0006     3235
      15      18      8     16.886    6.825    31579    3.998    {'O9.5'}      NaN    0.0004     4761
      18      24      5     20.163    8.454    33220    3.889    {'O8'  }      NaN    0.0003     7492
      24      32      3     27.835    9.037    39067    3.971    {'O6'  }      NaN    0.0002    11860];

MassRadius = table(cell2mat(Table(:,1)), cell2mat(Table(:,2)), cell2mat(Table(:,3)), cell2mat(Table(:,4)), ...
                    cell2mat(Table(:,5)), cell2mat(Table(:,6)), cell2mat(Table(:,7)), Table(:,8), ...
                    cell2mat(Table(:,9)), cell2mat(Table(:,10)), cell2mat(Table(:,11)));
                
MassRadius.Properties.VariableNames = {'M_low','M_up','N','M','R','T','logg','Sp','Mbol','M2L','L2M'};
MassRadius.Properties.VariableUnits = {'SunM','SunM','','SunM','SunR','K','cgs','','mag','Sun','erg/s/gr'};
