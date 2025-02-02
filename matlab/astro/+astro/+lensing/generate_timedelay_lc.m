function [T,F,TotalF,GalF,X,Y]=generate_timedelay_lc(T,XY,Alpha,TimeDelay,varargin)
% Generate random power-law power spectrum light curve and its time delays.
% Package: astro.lensing
% Description: Generate random power-law power spectrum light curve,
%              its time delays, total flux, and weighted mean position.
% Input  : - Times in which to generate LC.
%            If no parameter is given then default is (1:1:500)'.
%          - A two column matrix of [X Y] lens image positions.
%            If no parameter is given then default is [0 0; 1 0].
%          - A vector of image relative fluxes.
%            If no parameter is given then default is [1 0.5].
%          - Vector of time delay per image.
%            If no parameter is given then default is [0 50].
%          * Arbitrary number of pairs of arguments: ...,keyword,value,...
%            where keyword are one of the followings:
%            'ErrMag'  - Vector of magnitude errors, one per image.
%            'ErrPos'  - Positional error.
%            'GalMag'  - Galaxy magnitude.
%            'GalPos'  - Galaxy [X,Y] position.
%            'GalErrMag' - Galaxy magnitude error.
%            'Cadence' - Observing cadence.
%            'PowerLawInd' - Minus of power-spectrum power-law index.
%            'StdNorm' - Power spectrum std normlization.
%            'InterpMethod' - Interpolation method.
%            'MeanMag' - Mean magnitude of first image.
%            'ZP' - Photometriz zero point [mag].
% Output : - Vector of times.
%          - Matrix of lensed images flux. Column per image.
%          - Vector of total flux of images and galaxy.
%          - Galaxy flux.
%          - Weighted mean X position of blend.
%          - Weighted mean Y position of blend.
% License: GNU general public license version 3
%     By : Eran O. Ofek                    Jul 2017
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Example: [T,F,TotalF,X,Y]=astro.lensing.generate_timedelay_lc
% Reliable: 2
%--------------------------------------------------------------------------

Def.T         = (1:1:500)';
Def.XY        = [0 0; 1 0];
Def.Alpha     = [1 0.5];
Def.TimeDelay = [0 50];
if (nargin==0)
    T     = Def.T;
    XY    = Def.XY;
    Alpha = Def.Alpha;
    TimeDelay = Def.TimeDelay;
end


DefV.ErrMag              = 0.05;
DefV.ErrPos              = 0.03;
DefV.GalMag              = 20;
DefV.GalPos              = [0.5 0.5];
DefV.GalErrMag           = 0.05;
DefV.Cadence             = 1;
DefV.PowerLawInd         = 2;
DefV.StdNorm             = 0.3;
DefV.InterpMethod        = 'linear';
DefV.MeanMag             = 19;
DefV.ZP                  = 27;

InPar = InArg.populate_keyval(DefV,varargin,mfilename);

MaxTD = max(TimeDelay);
MinT  = min(T);
MaxT  = max(T);
Tcont = (MinT:InPar.Cadence:MaxT+MaxTD).';

% number of images
Nim = size(XY,1);
if (numel(InPar.ErrMag)==1)
    InPar.ErrMag = ones(1,Nim).*InPar.ErrMag;
end

% generate LC
FcontA = Util.stat.rand_ps(Tcont,[InPar.PowerLawInd, -InPar.StdNorm]);

% generated shift time series
% sample time series
% F is a matrix with flux per image in each column
F      = zeros(numel(T),Nim);

for Iim=1:1:Nim
    F(:,Iim)     = Alpha(Iim).*interp1(Tcont,FcontA(:,2),T+TimeDelay(Iim),InPar.InterpMethod);
end
NT = numel(T);

Mag = InPar.MeanMag + F + randn(NT,1).*InPar.ErrMag;
GalMag = InPar.GalMag + randn(NT,1).*InPar.GalErrMag;
% back to flux
F     = 10.^(-0.4.*(Mag-InPar.ZP));
GalF  = 10.^(-0.4.*(GalMag-InPar.ZP));

TotalF = sum(F,2) + GalF;

X = (sum(XY(:,1).'.*F,2) + InPar.GalPos(1).*GalF) ./TotalF;
Y = (sum(XY(:,2).'.*F,2) + InPar.GalPos(2).*GalF) ./TotalF;
X = X + randn(size(X)).*InPar.ErrPos;
Y = Y + randn(size(X)).*InPar.ErrPos;

            


