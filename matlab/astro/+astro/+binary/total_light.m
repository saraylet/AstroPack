function TotLum=total_light(R1, Args)
%,LimbFun,Nstep,Pars)
% Primary total light given its radius and limb darkening.
% Description: Calculate the primary total light given its radius and
%              limb darkening function or constant luminosity per unit area.
% Input  : - Primary star radius [consistent length unit].
%          - Handle of limb-darkening function: L(r,P1,P2,...),
%            where r is distance from
%            the star center in units of its radius, and L is the luminosity
%            per unit area in this radius, r.
%            P1,P2,... are optional parameters of LimbFun function
%            If constant number is given then it is taken as a constant
%            luminosity per unit area.
%          - Number of steps in numerical integration,
%            in case of non-constant LimbFun.
%            Default is 100.
%          - Cell array of optional parameters for limb-darkening function.
%            Default is {'Milne',1}.
% Output : - Total luminosity of star [consistent lum. unit].
%            Assuming surface brightness is 1.
% Tested : Matlab 5.3
%     By : Eran O. Ofek                    Aug 2001
%    URL : http://weizmann.ac.il/home/eofek/matlab/
% Example: TotLum=astro.binary.total_light(1,@astro.binary.limb_darkening,100,{'Wade',[1 1 1]});
% Reliable: 2
%---------------------------------------------------------------------------

arguments
    R1
    Args.LimbFun   = @astro.binary.limb_darkening;
    Args.Nstep     = 100;
    Args.Pars      = {'Milne',1};
end


if (isnumeric(Args.LimbFun))
   % constant luminosity per unit area
   TotLum = Args.LimbFun.*pi.*R1.^2;
else
   % limb darkening function
   % numerical solution
   
   % step size
   DelR = R1./Args.Nstep;
   
   R = (0:DelR:R1).';
   
   %L = eval([LimbFun,'(R./R1,Pars)']);
   L = Args.LimbFun(R./R1, Args.Pars{:});

   TotLum = trapz(R,2.*pi.*R.*L);
end

   
   
