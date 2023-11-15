function [AllResult,PM] = pointingModel(Files, Args)
    % Calculate pointing model from a lsit of images and write it to a configuration file.
    % Input  : - File name template to analyze.
    %            Default is 'LAST*PointingModel*sci*.fits'.
    %          * ...,key,val,...
    %            see code.
    % Example: R = pipeline.last.pointingModel([],'StartDate',[08 06 2022 17 54 00],'EndDate',[08 06 2022 18 06 00]);
    
    arguments
        Files                             = 'LAST*PointingModel*sci*.fits';
        Args.Dirs                         = 'ALL'; %{};
        Args.StartDate                    = [];
        Args.EndDate                      = [];
        Args.Nfiles                       = Inf;  % use only last N files
        %Args.Dir                          = pwd;
        Args.astrometryCroppedArgs cell   = {};
        %Args.backgroundArgs cell          = {};
        %Args.findMeasureSourcesArgs cell  = {};
        
        Args.PrepPointingModel logical    = true;
        Args.Nha                          = 20; %30
        Args.Ndec                         = 10; %15
        Args.MinAlt                       = 25; % [deg]
        Args.ObsCoo                       = [35 30];  % [deg]
        Args.ConfigFile                   = '/home/ocs/pointingModel.txt';
    end
    
    RAD = 180./pi;
    
    if isempty(Files)
        Files = 'LAST*sci*.fits';
    end
    
    PWD = pwd;
    
    if ischar(Args.Dirs)
        if strcmp(Args.Dirs, 'ALL')
            % find all 4 dirs of data
            for Icam=1:1:4
                Dirs{Icam} = pipeline.last.constructCamDir(Icam);
            end
        else
            Dirs{1} = Args.Dirs;
        end
    elseif iscell(Args.Dirs)
        % assuming already a cell array
        Dirs = Args.Dirs;
    else
        error('Dirs must be a char array or cell array');
    end
    
    Ndirs = numel(Dirs);
    for Idirs=1:1:Ndirs
        % For each camera (4 cameras on a LAST mount)  
        
        cd(Dirs{Idirs});

        List = ImagePath.selectByDate(Files, Args.StartDate, Args.EndDate);
        if numel(List)>Args.Nfiles
            List = List(end-Args.Nfiles+1:end);
        end

        fprintf('Number of images:')
        Nlist = numel(List)
        %List
        % Solve astrometry for all the pointing model images obtained by
        % one camera.
        for Ilist=1:1:Nlist
            Ilist
            List{Ilist}
            AI = AstroImage(List{Ilist});
            Keys = AI.getStructKey({'RA','DEC','HA','M_JRA','M_JDEC','M_JHA','JD','LST'});
            try
                [R, CAI, S] = imProc.astrometry.astrometryCropped(List{Ilist}, 'RA',Keys.RA, 'Dec',Keys.DEC, 'CropSize',[],Args.astrometryCroppedArgs{:});
            catch ME
                ME
                
                fprintf('Failed on image %d\n',Ilist);

                S.CenterRA = NaN;
                S.CenterDec = NaN;
                S.Scale = NaN;
                S.Rotation = NaN;
                S.Ngood = 0;
                S.AssymRMS = NaN;
                
                Keys.RA = NaN;
                Keys.DEC = NaN;
                Keys.HA = NaN;
                Keys.M_JRA = NaN;
                Keys.M_JDEC = NaN;
                Keys.M_JHA = NaN;
                
            end
            if Ilist==1
                Head   = {'RA','Dec','HA','M_JRA','M_JDEC','M_JHA','JD','LST','CenterRA','CenterDec','Scale','Rotation','Ngood','AssymRMS'};
                Nhead  = numel(Head);
                Table  = zeros(Nlist,Nhead);
            end
            Table(Ilist,:) = [Keys.RA, Keys.DEC, Keys.HA, Keys.M_JRA, Keys.M_JDEC, Keys.M_JHA, Keys.JD, Keys.LST, ...
                              S.CenterRA, S.CenterDec, S.Scale, S.Rotation, S.Ngood, S.AssymRMS];

        end

        Result = array2table(Table);
        Result.Properties.VariableNames = Head;
        
        mask = isnan(Result.RA);
        Result = Result(~mask,:);
        
        cd(PWD);

        % There was a sign bug here - fixed 15-Nov-2023
        TableDiff = array2table([-1.*(Result.CenterRA-Result.RA).*cosd(Result.CenterDec), -1.*(Result.CenterDec-Result.Dec)]);
        TableDiff.Properties.VariableNames = {'DiffHA','DiffDec'};

        Result = [Result, TableDiff];

        AllResult(Idirs).Result = Result;
        
        
        % generate scattered interpolanets
        AllResult(Idirs).Fha  = scatteredInterpolant(Result.HA, Result.Dec, Result.DiffHA,'linear','nearest');
        AllResult(Idirs).Fdec = scatteredInterpolant(Result.HA, Result.Dec, Result.DiffDec,'linear','nearest');
        
    end
    
    %writetable(AllResult(1).Result,'~/Desktop/nora/data/pm_rawdata.csv','Delimiter',',') 
    
    if Args.PrepPointingModel
        [TileList,~] = celestial.coo.tile_the_sky(Args.Nha, Args.Ndec);
        HADec = TileList(:,1:2);

        [Az, Alt] = celestial.coo.hadec2azalt(HADec(:,1), HADec(:,2), Args.ObsCoo(2)./RAD);

        % convert everything to degrees
        Az = Az*RAD;
        Alt = Alt*RAD;
        HADec = HADec*RAD;
        % convert to -180 to 180
        F180 = HADec(:,1)>180;
        HADec(F180,1) = HADec(F180,1) - 360;
        

        Flag = Alt>(Args.MinAlt);
        HADec = HADec(Flag,:);
        Ntarget = sum(Flag);
       
        ResidHA  = zeros(Ntarget,Ndirs);
        ResidDec = zeros(Ntarget,Ndirs);
        for Idirs=1:1:Ndirs
                        
            ResidHA(:,Idirs)  = AllResult(Idirs).Fha(HADec(:,1),HADec(:,2));
            ResidDec(:,Idirs) = AllResult(Idirs).Fdec(HADec(:,1),HADec(:,2));
        end
        
        % Choose Fields which have 4 operational cameras
%         Flag4 = all(~isnan(ResidHA),2);  % fields with 4 operational cameras
%         
%         MeanResidHA      = mean(ResidHA(Flag4,:),2,'omitnan');
%         MeanResidDec     = mean(ResidDec(Flag4,:),2,'omitnan');
%         CamOffsetHA      = ResidHA(Flag4,:) - MeanResidHA;  % the offset between each camera and the mean
%         CamOffsetDec     = ResidDec(Flag4,:) - MeanResidDec;  % the offset between each camera and the mean
%         MeanCamOffsetHA  = mean(CamOffsetHA);   % mean offset for each camera
%         MeanCamOffsetDec = mean(CamOffsetDec);   % mean offset for each camera
%         StdCamOffsetHA   = std(CamOffsetHA);   % mean offset for each camera
%         StdCamOffsetDec  = std(CamOffsetDec);   % mean offset for each camera
        
% use MeanCamOffset for camera w/o solution
% report the mean offsets and std
        
        
        MeanResidHA  = mean(ResidHA,2,'omitnan');
        MeanResidDec = mean(ResidDec,2,'omitnan');
        PM = [HADec, MeanResidHA, MeanResidDec];
        Flag = any(isnan(PM),2);
        PM   = PM(~Flag,:);
        
        % add these values to avoid extrapolation at dec 90 deg
        AtPole = [-135 90 0 0; -90 90 0 0; -45 90 0 0; 0 90 0 0; 45 90 0 0; 90 90 0 0; 135 90 0 0];
        PM = [PM; AtPole];
        
        if ~isempty(Args.ConfigFile)
            % write config file
            FID = fopen(Args.ConfigFile,'w');
            fprintf(FID,'# pointing model interpolation data\n');
            fprintf(FID,'# Generated on: %s\n',date);
            fprintf(FID,'# format:       [M_JHA,  M_JDec,  offsetHA,  offsetDec]\n');
            
            fprintf(FID,'PointingData : [\n');
            Npm = size(PM,1);
            for Ipm=1:1:Npm
                fprintf(FID,'         [%11.6f, %11.6f, %11.6f, %11.6f],\n',PM(Ipm,:));
            end
            fprintf(FID,'     ]\n');
            fclose(FID);
        end
        
        
        % plot pointing model
        factor = 15; % increase shifts for visibility


        f = figure('Position',[100,100,600,600]);
        hold on

        Npoints = length(Result.HA);
        for i=1:1:Npoints
    
            plot([Result.HA(i),Result.HA(i)+Result.DiffHA(i)*factor], [Result.Dec(i), Result.Dec(i)+Result.DiffDec(i)*factor], '-b','linewidth',3)

        end

        plot(Result.HA, Result.Dec, 'xb','MarkerSize',8)


        Npoints_inter = length(PM(:,1));
        for i=1:1:Npoints_inter
    
            plot([PM(i,1), PM(i,1)+PM(i,3)*factor], [PM(i,2), PM(i,2)+PM(i,4)*factor], '-r')
    
        end


        xlabel('HA (deg)')
        ylabel('Dec (deg)')
        title('Pointing Model (shifts increased by x15)')


        exportgraphics(f,'~/log/pointing_model.png','Resolution',300)
    end
    
end