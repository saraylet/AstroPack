function psfChi2_RangeIter(Cube, Std, PSF, DX, DY, HalfRangeX, HalfRangeY, Args)
    %
    
    arguments
        Cube
        Std
        PSF
        Args.WeightedPSF     = [];
        Args.FitRadius2      = [];
        Args.VecXrel         = [];
        Args.VecYrel         = [];
        Args.SumArgs cell    = {'omitnan'};
    end
    
    
    if isempty(Args.WeightedPSF)
        Args.WeightedPSF = sum(PSF.^2, [1 2]); % for flux estimation
    end
    
    if isempty(Args.VecXrel)
        % assume bith VecXrel and VecYrel are empty:
    
        [Ny, Nx, Nim] = size(Cube);
        Xcenter = Nx.*0.5 + 0.5;
        Ycenter = Ny.*0.5 + 0.5;
        Dof     = Nx.*Ny - 3;
    
        VecXrel = (1:1:Nx) - Xcenter;
        VecYrel = (1:1:Ny) - Ycenter;
    end
    
    
    if numel(Args.DX)==1 && Args.DX==0
        DX = [];
        DY = [];
    else
        DX = Args.DX;
        DY = Args.DY;
    end
    
    [Chi2_0, WeightedFlux_0, Dof] = imUtil.psf.psfChi2(Cube, Std, PSF,...
                                                               'DX',DX,...
                                                               'DY',DY,...
                                                               'MinFlux',Args.MinFlux,...
                                                               'WeightedPSF',Args.WeightedPSF,...
                                                               'FitRadius2',Args.FitRadius2,...
                                                               'VecXrel',Args.VecXrel,...
                                                               'VecYrel',Args.VecYrel,...
                                                               'SumArgs',Args.SumArgs);
                                                               
    [Chi2_xm, WeightedFlux_xm, Dof] = imUtil.psf.psfChi2(Cube, Std, PSF,...
                                                               'DX',DX - Args.HalfRangeX,...
                                                               'DY',DY,...
                                                               'MinFlux',Args.MinFlux,...
                                                               'WeightedPSF',Args.WeightedPSF,...
                                                               'FitRadius2',Args.FitRadius2,...
                                                               'VecXrel',Args.VecXrel,...
                                                               'VecYrel',Args.VecYrel,...
                                                               'SumArgs',Args.SumArgs);
                                                                                                  
  
    [Chi2_xp, WeightedFlux_xp, Dof] = imUtil.psf.psfChi2(Cube, Std, PSF,...
                                                               'DX',DX + Args.HalfRangeX,...
                                                               'DY',DY,...
                                                               'MinFlux',Args.MinFlux,...
                                                               'WeightedPSF',Args.WeightedPSF,...
                                                               'FitRadius2',Args.FitRadius2,...
                                                               'VecXrel',Args.VecXrel,...
                                                               'VecYrel',Args.VecYrel,...
                                                               'SumArgs',Args.SumArgs);
                                                                          
    [Chi2_ym, WeightedFlux_ym, Dof] = imUtil.psf.psfChi2(Cube, Std, PSF,...
                                                               'DX',DX,...
                                                               'DY',DY - Args.HalfRangeY,...
                                                               'MinFlux',Args.MinFlux,...
                                                               'WeightedPSF',Args.WeightedPSF,...
                                                               'FitRadius2',Args.FitRadius2,...
                                                               'VecXrel',Args.VecXrel,...
                                                               'VecYrel',Args.VecYrel,...
                                                               'SumArgs',Args.SumArgs);
                                                                                                  
  
    [Chi2_yp, WeightedFlux_yp, Dof] = imUtil.psf.psfChi2(Cube, Std, PSF,...
                                                               'DX',DX,...
                                                               'DY',DY + Args.HalfRangeY,...
                                                               'MinFlux',Args.MinFlux,...
                                                               'WeightedPSF',Args.WeightedPSF,...
                                                               'FitRadius2',Args.FitRadius2,...
                                                               'VecXrel',Args.VecXrel,...
                                                               'VecYrel',Args.VecYrel,...
                                                               'SumArgs',Args.SumArgs);
                                   
    % 
    
    
    
    
                                                           
    if isempty(Args.DX)
        % assume both DX and DY are empty
        Args.DX = 0;
        Args.DY = 0;
        ShiftedPSF = PSF;
    else
        ShiftedPSF = imUtil.trans.shift_fft(PSF, Args.DX, Args.DY);
    end
    
    
    
end