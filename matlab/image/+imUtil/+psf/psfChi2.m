function [Chi2, WeightedFlux, Dof, ShiftedPSF] = psfChi2(Cube, Std, PSF, Args)
    % Given a PSF and cube of sources stamps, fit flux and calculate the \chi^2
    %   Optionally shift the PSF by DX,DY
    % Input  : - A cube of stamps around sources, in which the stamps index
    %            is in the 3rd dimension.
    %          - A cube, matrix or scalar, of std (error) in stamps.
    %          - A matrix of PSF which size is like the stamps size in the
    %            first two dimensions.
    %          * ...,key,val,...
    %            'DX' - A vector which length is like the number of stamps
    %                   containing the X shift to apply to the PSF prior to the
    %                   fit.
    %                   If empty, then do not shift PSF.
    %                   Default is [].
    %            'DY' - Like 'DX', but for the Y shift.
    %                   Default is [].
    %            'WeightedPSF' - sum(PSF.^2, [1 2])
    %                   If empty, then will recalculate.
    %                   Default is [].
    %            'FitRadius2' - Radius.^2 around the PSF center of pixels
    %                   to use in the fit.
    %                   If empty, then use the entire stamp.
    %                   Default is [].
    %            'VecXrel' - A vector of relative X positions in the stamp.
    %                   If empty, then use: (1:1:Nx) - Xcenter.
    %                   Default is [].
    %            'VecYrel' - Like 'VecXrel', but for the Y positions.
    %                   Default is [].
    % Output : - Vector of \chi^2 per stamp.
    %          - Vector flux measured for each stamp.
    %          - Degrees of freedom (number of used pixel - 3).
    %          - Cube of shifted PSFs.
    % Author : Eran Ofek (Jun 2023)
    % Example: Cube=randn(15,15,1000); Std=randn(15,15,1000);
    %          PSF = imUtil.kernel2.gauss(2,[15 15]);
    %          [Chi2,Flux,Dof]=imUtil.psf.psfChi2(Cube, Std, PSF);
    
    arguments
        Cube
        Std
        PSF
        Args.DX           = []
        Args.DY           = [];
        Args.WeightedPSF  = [];
        Args.FitRadius2   = [];
        Args.VecXrel      = [];
        Args.VecYrel      = [];
        %Args.FluxMethod   = 'wsumall';
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
    
    if isempty(Args.DX)
        % assume both DX and DY are empty
        DX = 0;
        DY = 0;
        ShiftedPSF = PSF;
    else
        ShiftedPSF = imUtil.trans.shift_fft(PSF, DX, DY);
    end
        
    WeightedFlux = sum(Cube.*ShiftedPSF, [1 2], 'omitnan')./Args.WeightedPSF;
    
    Resid = Cube - WeightedFlux.*ShiftedPSF;
    
    % FFU: search / remove outliers

    if isempty(Args.FitRadius2)
        % use the entire stamp
        ResidStd2 = (Resid./Std).^2;
        Dof      = [];
    else
        MatX     = permute(VecXrel - DX(:),[3 2 1]);
        MatY     = permute(VecYrel - DY(:),[2 3 1]);
        MatR2    = MatX.^2 + MatY.^2;
        Flag     = MatR2<Args.FitRadius2;
        ResidStd2= (Flag.*Resid./Std).^2;
        Dof      = squeeze(sum(Flag,[1 2]) - 3);
    end
    
    Chi2  = sum( ResidStd2, [1 2], 'omitnan');
    %Chi2  = sum( (Resid./Std).^2, [1 2], 'omitnan');
    Chi2  = squeeze(Chi2);
    
end

    
        