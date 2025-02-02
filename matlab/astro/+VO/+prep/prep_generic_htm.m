function prep_generic_htm(varargin)
% Prepare generic catsHTM catalog from declination zone catalogs
% Package: VO.prep
% Description: Prepare generic catsHTM catalog from declination zone
%              catalogs.
% Input  : * Arbitrary number of pairs of arguments: ...,keyword,value,...
%            where keyword are one of the followings:
%            '
% Output : null
% License: GNU general public license version 3
%     By : Eran O. Ofek                    Feb 2018
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Example: VO.prep.prep_generic_htm
% Reliable: 2
%--------------------------------------------------------------------------

RAD = 180./pi;

DefV.CatName             = 'GAIADR3'; %'URAT1'; % 'GALEX2mEpochs'; %'URAT1'; %'PS1ps';  %'NEDz'; %'GAIADR2'; %'HSCv2'; %'SAGE'; %'SWIREz'; %'SDSSoffset'; %'VSTkids';
DefV.FileBaseName        = 'GaiaDRE3'; %'urat1'; % 'GALEX2mEpochs'; %'URAT1'; % 'ned'; %'GaiaDR2'; %'HSC'; %'SpitzerSAGE'; % 'swire'; %'MyTable'; %'kids';
DefV.FileExtName         = '.hdf5'; %'.fit'; %'h5'; %'txt';%'hdf5'; %'.mat'; %'.fit'; %'.mat'; %'.fit';
DefV.FileSplit           = '_';
DefV.FileType            = 'hdf5'; %'fits'; %'hdf5'; %'ned'; %'hdf5'; %'astcat'; %'astcat'; 'fits'; %'mat'; %'fits';
DefV.UseMforMinus        = true; %true;
DefV.DecSize             = 1;  % deg
DefV.HTM_Level           = 9;
DefV.HTMsize             = [];

InPar = InArg.populate_keyval(DefV,varargin,mfilename);

[HTM,LevelHTM] = celestial.htm.htm_build(InPar.HTM_Level);
if (isempty(InPar.HTMsize))
    InPar.HTMsize  = LevelHTM(end).side.*RAD+0.05;
end


Files=dir(sprintf('%s*%s',InPar.FileBaseName,InPar.FileExtName));
Nf   = numel(Files);

RegExp = regexp({Files.name},InPar.FileSplit,'split');
Dec1   = nan(Nf,1);
Dec2   = nan(Nf,1);
for If=1:1:Nf
    StrDec1 = RegExp{If}{2};
    StrDec2 = RegExp{If}{3};
    StrDec2 = StrDec2(1:end-numel(InPar.FileExtName));
    
    if (InPar.UseMforMinus)
        if (strcmp(StrDec1(1),'m'))
            Dec1(If) = -str2double(StrDec1(2:end));
        else
            Dec1(If) = str2double(StrDec1);
        end
        if (strcmp(StrDec2(1),'m'))
            Dec2(If) = -str2double(StrDec2(2:end));
        else
            Dec2(If) = str2double(StrDec2);
        end
    else
        Dec1(If) = str2double(StrDec1);
        Dec2(If) = str2double(StrDec2);
    end
    
end

% sort by declination
[~,SI] = sort(Dec1);
Dec1   = Dec1(SI);
Dec2   = Dec2(SI);
Files  = Files(SI);

for If=266:1:Nf
    tic;
    clear Cat;
    [If, Nf]
    
    Id = find(Dec1>(Dec1(If)-InPar.DecSize) & Dec2<(Dec2(If)+InPar.DecSize));
    Id = [Id; If-1; If+1];
    Id = unique(Id);
    Id = Id(Id>0 & Id<=Nf);
    
    DecLim = [(Dec1(If)-InPar.HTMsize), (Dec2(If)+InPar.HTMsize)]./RAD;
    
    Nid = numel(Id);
    for Iid=1:1:Nid
        %Id
        %Iid
           
            Files(Id(Iid)).name;
            Cat(Iid) = load_file(Files(Id(Iid)).name,InPar.FileType,  DecLim );
    end
    Cat = merge(Cat);
  
    
    % reorganize the catalog (specific)
    % ATLAS
%     ColCell  = Cat.ColCell(3:end);
%     ColUnits = Cat.ColUnits(3:end);
%     Cat.Cat = Cat.Cat(:,3:end);
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Tmp = Cat.Cat(:,5:end);
%     FF=Tmp>-1e-30 & Tmp<0;
%     Tmp(FF) = NaN;
%     Cat.Cat(:,5:end) = Tmp;
    % Viking
%     ColCell  = Cat.ColCell;
%     ColUnits = Cat.ColUnits;
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Tmp = Cat.Cat(:,8:end);
%     FF=Tmp>-1e-30 & Tmp<0;
%     Tmp(FF) = NaN;
%     Cat.Cat(:,8:end) = Tmp;

%     % KiDS
%     ColCell  = Cat.ColCell(3:end);
%     ColUnits = Cat.ColUnits(3:end);
%     Cat.Cat = Cat.Cat(:,3:end);
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Tmp = Cat.Cat(:,12:19);
%     FF=Tmp>-1e-30 & Tmp<0;
%     Tmp(FF) = NaN;
%     Cat.Cat(:,12:19) = Tmp;
    
    % SDSS offset
    
    
%     ColCell{1} = 'RA';
%     ColCell{2} = 'Dec';
%     ColUnits   = {'rad','rad','arcsec','arcsec','','','deg/day','deg/day','mag','mag','mag','mag','mag','mag','mag','mag','mag','mag','arcsec','arcsec','arcsec','arcsec','arcsec','arcsec','arcsec','arcsec','arcsec','arcsec','MJD'};
%     Cat        = sortrows(Cat,2);
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Cat.Cat(:,end) = Cat.Cat(:,end)./86400;
%     
    % IPHAS
    
    % SWIRE
    % SAGE
%     Cat.Cat = Cat.Cat(:,3:end);
%     Cat.ColCell = Cat.ColCell(3:end).';
%     Cat.ColUnits = Cat.ColUnits(3:end);
%     Cat.ColCell{1} = 'RA';
%     Cat.ColCell{2} = 'Dec';
%     Cat.ColCell{9} = 'Mag3.6';
%     Cat.ColCell{10} = 'ErrMag3.6';
%     Cat.ColCell{11} = 'Mag4.5';
%     Cat.ColCell{12} = 'ErrMag4.5';
%     Cat.ColCell{13} = 'Mag5.8';
%     Cat.ColCell{14} = 'ErrMag5.8';
%     Cat.ColCell{15} = 'Mag8.0';
%     Cat.ColCell{16} = 'ErrMag8.0';
%     Cat.ColUnits{1} = 'rad';
%     Cat.ColUnits{2} = 'rad';
%     
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Cat            = sortrows(Cat,2);
%     Tmp = Cat.Cat(:,3:end);
%     FF=Tmp>-1e-30 & Tmp<0;
%     Tmp(FF) = NaN;
%     Cat.Cat(:,3:end) = Tmp;

    %
    
    % HSC
%     ColCell  = Cat.ColCell;
%     ColUnits = Cat.ColUnits;

    % GAIA/DR2    
%     Cat.ColCell = {'RA','Dec','Epoch','ErrRA','ErrDec','Plx','ErrPlx','PMRA','ErrPMRA','PMDec','ErrPMDec','RA_Dec_Corr',...
%            'ExcessNoise','ExcessNoiseSig','MagErr_G','Mag_G','MagErr_BP','Mag_BP','MagErr_RP','Mag_RP',...
%            'RV','ErrRV','VarFlag','Teff','Teff_low','Teff_high','A_G'};
%     Cat.ColUnits = {'rad','rad','JYear','mas','mas','mas','mas','mas/yr','mas/yr','mas/yr','mas/yr','','mas','',...
%                     'mag','mag','mag','mag','mag','mag','km/s','km/s','K','K','K','mag'};

    % NED
    
    % URAT1
%     Cat.Cat = Cat.Cat(:,3:15);
%     Cat.ColCell = {'RA','Dec','PosErrScatter','PosErrModel','Nset','Nmeanpos','Epoch','Mag','MagErr','Nmag','PM_RA','PM_Dec','PMErr'};
%     Cat.ColUnits = {'rad','rad','mas','mas','','','JYear','mag','mag','','mas/yr','mas/yr','mas/yr'};
%     Cat = colcell2col(Cat);
%     Cat.Cat(:,1:2) = Cat.Cat(:,1:2)./RAD;
%     Cat = sortrows(Cat,'Dec');
%     FFF = abs(Cat.Cat(:,11))<1e-32 &  abs(Cat.Cat(:,12))<1e-32 & abs(Cat.Cat(:,13))<1e-32;
%     Cat.Cat(FFF,11:13) = NaN;
  
    % GALEX2mCoadd
    
    %GAIAEDR3
  
    Cat.ColCell = {'RA','Dec','Epoch','ErrRA','ErrDec','Plx','ErrPlx','PMRA','ErrPMRA','PMDec','ErrPMDec','RA_Dec_Corr',...
           'ExcessNoise','ExcessNoiseSig','MagErr_G','Mag_G','MagErr_BP','Mag_BP','MagErr_RP','Mag_RP',...
           'RV','ErrRV','Teff'};
       
    % GAIA-DR3
    Cat.ColCell = [    {'RA'                          }
    {'Dec'                         }
    {'Epoch'                       }
    {'ErrRA'                       }
    {'ErrDec'                      }
    {'Plx'                         }
    {'ErrPlx'                      }
    {'PMRA'                        }
    {'ErrPMRA'                     }
    {'PMDec'                       }
    {'ErrPMDec'                    }
    {'ra_dec_corr'                 }
    {'astrometric_n_obs_al'        }
    {'astrometric_n_obs_ac'        }
    {'astrometric_n_good_obs_al'   }
    {'astrometric_n_bad_obs_al'    }
    {'astrometric_gof_al'          }
    {'astrometric_excess_noise'    }
    {'astrometric_excess_noise_sig'}
    {'astrometric_chi2_al'         }
    {'astrometric_params_solved'   }
    {'nu_eff_used_in_astrometry'   }
    {'pseudocolour'                }
    {'pseudocolour_error'          }
    {'astrometric_sigma5d_max'     }
    {'phot_g_n_obs'                }
    {'phot_g_mean_mag'             }
    {'phot_g_mean_flux_over_error' }
    {'phot_bp_mean_mag'            }
    {'phot_bp_mean_flux_over_error'}
    {'phot_rp_mean_mag'            }
    {'phot_rp_mean_flux_over_error'}
    {'phot_bp_rp_excess_factor'    }
    {'bp_rp'                       }
    {'radial_velocity'             }
    {'radial_velocity_error'       }
    {'rv_amplitude_robust'         }
    {'in_qso_candidates'           }
    {'in_galaxy_candidates'        }
    {'non_single_star'             }
    {'has_xp_continuous'           }
    {'teff_gspphot'                }
    {'teff_gspphot_lower'          }
    {'teff_gspphot_upper'          }
    {'logg_gspphot'                }
    {'logg_gspphot_lower'          }
    {'logg_gspphot_upper'          }
    {'mh_gspphot'                  }
    {'mh_gspphot_lower'            }
    {'mh_gspphot_upper'            }
    {'azero_gspphot'               }
    {'azero_gspphot_lower'         }
    {'azero_gspphot_upper'         }];


    Cat.ColUnits = {'rad','rad','JYear','mas','mas','mas','mas',...
        'mas/yr','mas/yr','mas/yr','mas/yr',...
        '','','','','','',...
        'mas','',...
        '','','','','',...
        'mas',...
        '','mag','s/n','mag','s/n','mag','s/n',...
        '','mag',...
        'km/s','km/s','km/s',...
        'bool','bool','bool','bool',...
        'K','K','K','logg','logg','logg','[Fe/H]','[Fe/H]','[Fe/H]',...
        'mag','mag','mag'};
        
        
    DecRange    = [Dec1(If), Dec2(If)]./RAD;
    VO.prep.build_htm_catalog(Cat.Cat,'HTM_Level',InPar.HTM_Level,'CatName',InPar.CatName,'SaveInd',false,'DecRange',DecRange,...
                              'HTM',HTM,'LevelHTM',LevelHTM);
    [If, Nf, toc]
end

ColCell = Cat.ColCell(:)';
ColUnits = Cat.ColUnits(:)';


% prep ind file
% save HTM index file
IndFileName = sprintf('%s_htm.hdf5',InPar.CatName);
delete(IndFileName);
Nsrc=HDF5.get_nsrc(InPar.CatName);
catsHTM.save_htm_ind(InPar.HTM_Level,IndFileName,[],ColCell,Nsrc)

catsHTM.save_cat_colcell(InPar.CatName,ColCell,ColUnits);


end


function Cat=load_file(File,Type,DecLim)

if (nargin<3)
    DecLim = [];
end

switch lower(Type)
    case 'fits'
        File
        Cat = FITS.read_table(File,'ModColName',true);
        Ncol = numel(Cat.ColCell);
        for Icol=1:1:Ncol
            Cat.ColCell{Icol}=Cat.ColCell{Icol}(2:end);
        end
    case 'mat'
        Cat.Cat = io.files.load2(File);
        FID=fopen('columns','r'); C=textscan(FID,'%s\n');fclose(FID);
        Cat.ColCell=C{1}';
        Cat = AstCat.struct2astcat(Cat);
    case 'astcat'
        Cat = io.files.load2(File);
    case 'hdf5'
        Cat.Cat = h5read(File,'/V');
        Cat = AstCat.struct2astcat(Cat);
        if (~isempty(DecLim))
            FF = Cat.Cat(:,2)>DecLim(1) & Cat.Cat(:,2)<DecLim(2);
            Cat.Cat = Cat.Cat(FF,:);
        end
        
    case 'ned'
        [Mat,ColCell,ColUnits] = read_ned(File);
        Cat = AstCat;
        Cat.Cat = Mat;
        Cat.ColCell = ColCell;
        Cat = colcell2col(Cat);
        Cat.ColUnits = ColUnits;
    otherwise
        error('Unknown Type option');
end

end


function [Mat,ColCell,ColUnits]=read_ned(FileName)

RAD = 180./pi;

FID = fopen(FileName,'r');
FL=NaN;
for I=1:1:40
    Line=fgetl(FID);
    if (~isempty(strfind(Line,'No.|')))
        FL=I;
    end
end
fclose(FID);

FID=fopen(FileName,'r');
C = textscan(FID,'%*s %*s %f %f %s %f %f %s %s %*[^\n]','Delimiter','|','HeaderLines',FL);
fclose(FID);
ColCell = {'RA','Dec','ObjType','Velocity','z','RedshiftType','Mag','Filter'};
ColUnits= {'rad','rad','','km/s','','','mag',''};

try
    load Dic.mat
catch
    DicObjType      = tools.struct.struct_def({'Ind','Name'},0,1);
    DicRedshiftType = tools.struct.struct_def({'Ind','Name'},0,1);
    DicFilter       = tools.struct.struct_def({'Ind','Name'},0,1);
end

    
[Vector,DicObjType]=tools.cell.cellstr2num_dictionary(C{3},DicObjType);

C{3} = Vector;
[Vector,DicRedshiftType]=tools.cell.cellstr2num_dictionary(C{6},DicRedshiftType);
C{6} = Vector;

Tmp = regexp(C{7},'(?<Mag>\d+\.\d+)(?<Filter>\w*)','names');
FlagE = cellfun(@isempty,Tmp);
TT  = cell2mat(Tmp);
Vector = nan(numel(C{7}),1);
[Vector(~FlagE),DicFilter]=tools.cell.cellstr2num_dictionary({TT.Filter},DicFilter);
C{8} = Vector;

Vector = nan(numel(C{7}),1);
Vector(~FlagE) = cellfun(@str2double,{TT.Mag}');
C{7} = Vector;

Mat = [C{:}];

Mat(:,1:2) = Mat(:,1:2)./RAD;

save Dic.mat DicObjType DicRedshiftType DicFilter

end