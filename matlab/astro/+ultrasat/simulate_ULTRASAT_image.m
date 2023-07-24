function simImage = simulate_ULTRASAT_image (Args)
    % Simulate with ultrasat.usim a realistic distribution of sky sources 
    % Input: -
    %           
    % Output : - Image: a 2D array containing the resulting source image                 
    %            
    % By : A. Krassilchtchikov et al. Mar 2023
    % Example: Image = simulate_ULTRASAT_image('ExpNum', 30, 'OutDir', '/home/sasha/', 'Same', true)
    
    arguments    
        Args.Size       = 0.5;            % [deg] size of the modelled FOV 
        Args.X0         = 1e-6;           % [deg] the lower left corner of the modelled square region
        Args.Y0         = 1e-6;           % [deg] the lower left corner of the modelled square region
        Args.ExpNum     = 3;              % number of standard 300 s exposures
        Args.Same       = 0;              % read in a source distribution or generate a random new one
        Args.Distfile   = 'fitted_distr_cat.mat'; % if Same=1, read the input distr. from this file
        Args.OutDir     =  '.'  ;         % output directory
    end
    
    %%%%% ULTRASAT parameters
    
%     ImageSizeX = 4738;
%     ImageSizeY = 4738;
    PixSize    = 5.44; % pixel size (arcsec)
    
%     STile = PixSize^2 * ImageSizeX * ImageSizeY / (3600^2); % tile size in [deg]
    
    Wave       = 2000:11000; % the wavelength band in A
                     
    if ~Args.Same % model a new distribution
        
        MagL = 13; MagH = 26; Delta_m = 0.2; % the distribution grid in NUV Mag (from GALEX)       
        MagBins = (MagH - MagL) / Delta_m;
        
        Mag       = zeros(MagBins,1);
        SrcDist   = zeros(MagBins,1);
        
        for iMag = 1:1:MagBins
            
            Mag(iMag)  = MagL + (iMag - 1) * Delta_m;
            
            SrcDeg     = 10.^( 0.35 * Mag(iMag) - 4.9 );   % per 1 deg^2 fitted from the GALEX data
            SrcDist(iMag) = ceil( SrcDeg * Args.Size^2 );  % rescaled for Args.Size^2 
            
        end
        
        NumSrc = sum(SrcDist,'all');
        
        Cat    = zeros(NumSrc,2);
        MagUS  = zeros(NumSrc,1);
        FiltUS = repmat({ },1,NumSrc);
%         
%         S(1,:) = AstroSpec.blackBody(Wave',3500).Flux; % appears to slow!
%         S(2,:) = AstroSpec.blackBody(Wave',5800).Flux;
%         S(3,:) = AstroSpec.blackBody(Wave',20000).Flux;
%         
        S(1) = AstroSpec.blackBody(Wave',3500);
        S(2) = AstroSpec.blackBody(Wave',5800);
        S(3) = AstroSpec.blackBody(Wave',20000);
        
        % read the relation of NUV magnitudes and ULTRASAT magnitude for a
        % give set of source spectra (usually, just the 3 BB temperatures)  
        io.files.load1('/home/sasha/magu.mat'); % variables: MagU (3D), Temp, MagNUV, Rad  
             
        X0 = ceil(Args.X0 * 3600 / PixSize); % left corner of the modelled square region
        Y0 = ceil(Args.Y0 * 3600 / PixSize); % left corner of the modelled square region        
        Range = Args.Size * 3600 / PixSize;  % X and Y size of the modelled square region
        rng('shuffle');                      % reseed the random number generator
        Cat(:,1) = X0 + Range * rand(NumSrc,1);
        rng('shuffle');                      % reseed the random number generator
        Cat(:,2) = Y0 + Range * rand(NumSrc,1); 
        
        Isrc = 0; 
        for iMag = 1:1:MagBins 
            
            for jSrc = 1:1:SrcDist(iMag)
                
                Isrc = Isrc + 1;
                
                RadSrc = sqrt( Cat(Isrc,1)^2 + Cat(Isrc,2)^2 ) * (PixSize/3600); %deg
                [~, IndR] = min( abs(RadSrc - Rad) ); % search for the nearest node
                RXX = sprintf('R%d',IndR); FiltUS{Isrc} = RXX; % fill in the appropriate filter
                
                % divide the population into 3 colours: 
                IndT = rem(Isrc,3) + 1; Spec(Isrc,:) = S(IndT);
                
                [~, IndM] = min( abs( Mag(iMag) - MagNUV ) ); % search for the nearest magnitude (from the magu.mat grid)
                
                MagUS(Isrc) = MagU( IndT, IndM, IndR );
                
            end
            
        end
        
        % save the catalog for the case you wish to repeat the same setup
        % (for large simulations this can be way too voluminous)
        
%         save('fitted_distr_cat.mat', 'Cat','MagUS', 'FiltUS', 'Spec', '-v7.3');
        
    else
        % read in the catalog, magnitudes, and spectra to be modelled       
        DataFile = sprintf('%s%s',tools.os.getAstroPackPath,Args.Distfile);
        io.files.load1(DataFile);  % load Cat, MagUS, FiltUS, Spec,
        
    end
    
    simImage = ultrasat.usim_dev('InCat',Cat,'MaxNumSrc',10000,'InMag',MagUS,'Filt',FiltUS, ...
               'Spec',Spec,'Exposure',[Args.ExpNum 300],'FiltFam',{'ULTRASAT'},'OutDir',Args.OutDir);
    
end
