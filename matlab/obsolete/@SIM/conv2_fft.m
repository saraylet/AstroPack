function Sim=conv2_fft(Sim,Psf,varargin)
% Convolve SIM object images with some PSF.
% Package: @SIM
% Description: Convolve SIM object images with some PSF.
%              This function uses the conv2_fft.m function, which is
%              slightly faster than conv_fft2.m.
%              If PSF is smaller than about 5% of the image size, in each
%              dimension, then consider using conv2.m.
% Input  : - A SIM object images array.
%          - A point spread function with which to convolve the first SIM
%            input. The options available are described inbfun2sim.m,
%            with the exception of an array of scalars. An array will be
%            interpreted as a convolution kernel.
%            Options: SIM, PSF, Array, cell of arrays,function habdle.
%            Alternatively, if empty or not provided than will attempt
%            to obtain the PSF from the ClassPSF object in the SIM.
%          * Additional parameters to pass to bfun2sim.m.
%            For example use 'ExecField' to specify on which SIM fields
%            to perform the operation.
% Output : - A SIM object with the convolved images.
% See also: SIM/conv2.m, SIM/conv_fft2.m
% License: GNU general public license version 3
% Tested : Matlab R2015b
%     By : Eran O. Ofek                    Apr 2016
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Example: SimC = conv2_fft(Sim);
%          SimC = conv2_fft(Sim,ones(5,5));
%          % second input is a function
%          SimC = conv2_fft(S1,@Kernel2.gauss)
%          % second input is a function, and pass parameters to the fun:
%          SimC = conv2_fft(S1,@Kernel2.gauss,'Sim2FunPar',{5,5});
%          % second iinput is a matrix generated by a function call
%          SimC = conv2_fft(S1,Kernel2.gauss(5,5));
% Reliable: 2
%--------------------------------------------------------------------------


if (nargin==1)
    Psf = [];
end

if (isempty(Psf))
    % attempt to read PSF from ClassPSF object in SIM
    Psf = getmpsf(Sim);
end

if (isnumeric(Psf))
    Psf = {Psf};
end

Sim = bfun2sim(Sim,Psf,@ImUtil.Im.conv2_fft,varargin{:});

