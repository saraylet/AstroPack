function Result = unitTest
    % unitTest for imUtil.sources
    % Example: Result = imUtil.sources.unitTest
    
    
    % imUtil.sources.findSources
    Image = randn(1700, 1700);
    Result = imUtil.sources.findSources(Image,'Threshold',6);
    if numel(Result.XPEAK)>0
        error('Problem with imUtil.sources.findSources');
    end
    
    
    % imUtil.sources.aperPhotCube
    % simple case
    Cube = randn(17,17,4000); X=ones(4000,1).*9; Y=X;
    imUtil.sources.aperPhotCube(Cube, X, Y);
    PSF  = imUtil.kernel2.gauss([1.5;2],[17 17]);
    imUtil.sources.aperPhotCube(Cube, X, Y, 'PSF',PSF);
    imUtil.sources.aperPhotCube(Cube, X, Y, 'PSF',PSF,'SubPixShift','fft');
    % PSF case w/o noise
    Nsrc  = 10;
    Flux  = rand(Nsrc, 1).*100;
    Cube  = imUtil.kernel2.gauss(1.5.*ones(Nsrc,1),[17 17]);
    Cube  = Cube.*permute(Flux,[3 2 1]);
    Ratio = squeeze(sum(Cube,[1 2]))./Flux;
    if abs(Ratio-1)>1e-6
        error('Problem with imUtil.sources.aperPhotCube simulations');
    end
    Result = imUtil.sources.aperPhotCube(Cube, 9.*ones(Nsrc,1), 9.*ones(Nsrc,1), 'AperRad',[2 4 5 6]);
    % maximal relative flux error (without noise)
    max(abs(([Result.AperPhot(4).Phot - Flux]./Flux)))
    
    % PSF case with noise
    Nsrc  = 10;
    Flux  = rand(Nsrc, 1).*1e6;
    Cube  = imUtil.kernel2.gauss(1.5.*ones(Nsrc,1),[25 25]);
    Cube  = Cube.*permute(Flux,[3 2 1]) + randn(25,25,Nsrc).*0.1;    
    Result = imUtil.sources.aperPhotCube(Cube, 13.*ones(Nsrc,1), 13.*ones(Nsrc,1), 'AperRad',[2 4 5 6]);
    % maximal relative flux error (without noise)
    [Flux, abs(([Result.AperPhot(4).Phot - Flux]./Flux))]
    if min(abs([Result.AperPhot(4).Phot - Flux]./Flux))>0.001
        error('Problem with imUtil.sources.aperPhotCube');
    end
    
    % PSF photometry with Poisson noise
    PSF = imUtil.kernel2.gauss(1.5,[25 25]);
    Nsrc  = 10;
    Flux  = rand(Nsrc, 1).*1e6;
    Cube  = imUtil.kernel2.gauss(1.5.*ones(Nsrc,1),[25 25]);
    Cube  = Cube.*permute(Flux,[3 2 1]); % + randn(25,25,Nsrc).*0.1;
    Cube  = poissrnd(Cube) + randn(25,25,Nsrc).*0.1;
    Result = imUtil.sources.aperPhotCube(Cube, 13.*ones(Nsrc,1), 13.*ones(Nsrc,1), 'AperRad',[2 4 5 6],'PSF',PSF);
    % maximal relative flux error (without noise)
    [Flux, abs(([Result.PsfPhot(1).Phot - Flux]./Flux))]
    if max(abs([Result.PsfPhot(1).Phot - Flux]./Flux))>0.01
        error('Problem with imUtil.sources.aperPhotCube');
    end

    % with error in PSF
    PSF = imUtil.kernel2.gauss(1.6,[25 25]);
    Nsrc  = 10;
    Flux  = rand(Nsrc, 1).*1e6;
    Cube  = imUtil.kernel2.gauss(1.5.*ones(Nsrc,1),[25 25]);
    Cube  = Cube.*permute(Flux,[3 2 1]); % + randn(25,25,Nsrc).*0.1;
    Cube  = poissrnd(Cube) + randn(25,25,Nsrc).*0.1;
    Result = imUtil.sources.aperPhotCube(Cube, 13.*ones(Nsrc,1), 13.*ones(Nsrc,1), 'AperRad',[2 4 5 6],'PSF',PSF);
    % maximal relative flux error (without noise)
    [Flux, abs(([Result.PsfPhot(1).Phot - Flux]./Flux))]
    if max(abs([Result.PsfPhot(1).Phot - Flux]./Flux))>0.1
        error('Problem with imUtil.sources.aperPhotCube');
    end
    
    
    % now with sub-pix shifts / no noise
    PSF = imUtil.kernel2.gauss(1.5+0.15,[25 25]);
    Nsrc  = 10;
    Flux  = rand(Nsrc, 1).*1e6;
    Cube  = imUtil.kernel2.gauss(1.5.*ones(Nsrc,1),[25 25]);
    % shift the Cube
    DX = rand(Nsrc,1).*4;
    DY = rand(Nsrc,1).*4;
    ShiftedCube = zeros(size(Cube));
    for Isrc=1:1:Nsrc
        [ShiftedCube(:,:,Isrc)]=imUtil.trans.shift_fft(Cube(:,:,Isrc),DX(Isrc),DY(Isrc));
        %[ShiftedCube(:,:,Isrc)]=imUtil.trans.shift_lanczos(Cube(:,:,Isrc),[DX(Isrc),DY(Isrc)]);
    end
    
    ShiftedCube  = ShiftedCube.*permute(Flux,[3 2 1]); % + randn(25,25,Nsrc).*0.1;
    %ShiftedCube  = poissrnd(ShiftedCube) + randn(25,25,Nsrc).*0.1;
    Result = imUtil.sources.aperPhotCube(ShiftedCube, 13.*ones(Nsrc,1)+DX, 13.*ones(Nsrc,1)+DY, 'AperRad',[2 4 5 6],'PSF',PSF,'SubPixShift','fft');
    [Flux, abs(([Result.PsfPhot(1).Phot - Flux]./Flux))]   % fantastic with fft shift!
    % 10% error in PSF width -> 10% bias in photometry
    
    ErrorShift = logspace(-5,0,10);
    for I=1:1:numel(ErrorShift)
        Result = imUtil.sources.aperPhotCube(ShiftedCube, 13.*ones(Nsrc,1)+DX+ErrorShift(I), 13.*ones(Nsrc,1)+DY+ErrorShift(I), 'AperRad',[2 4 5 6],'PSF',PSF,'SubPixShift','fft');
        Mean(I) = mean(abs(([Result.PsfPhot(1).Phot - Flux]./Flux)));
    end
    %loglog(ErrorShift.*sqrt(2),Mean)  
    Par = polyfit(log10(ErrorShift.*sqrt(2)),log10(Mean),1);
    % The photometric error as a function of positional shift is: ~0.1 x (TotalShift./1)^2

    Result = true;
end
