% INPOP
%


classdef INPOP < Base
    % OrbitalEl class for storing and manipulating orbital elements

    % Properties
    properties
        
    end
    
    methods % constructor
      
        
    end
    
    methods (Static) % download/create INPOP files
        function FileName = inpopFileName(Args)
            % Construct INPOP data file name
            % Input  : * ...,key,val,...
            %            'Object' - Object name. If 'tar' then return the
            %                   tar file name.
            %                   Otherwise, this is a planet name.
            %            'FileData' - ['pos'] | 'vel'.
            %            'Version' - Default is 'inpop21a'.
            %            'TimeScale' - ['TDB'] | 'TCB'.
            %            'FileType' - Default is 'asc'.
            %            'TimePeriod' - ['100'] | '1000'.
            % Author : Eran Ofek (Apr 2022)
            % Example: celestial.INPOP.inpopFileName
            %          celestial.INPOP.inpopFileName('Object','Plu')
            
            arguments
                Args.Object        = 'tar';
                Args.Version       = 'inpop21a';
                Args.TimeScale     = 'TDB';   % 'TDB' | 'TCB'
                Args.FileType      = 'asc';
                Args.TimePeriod    = '100';    % '100' | '1000'
                Args.FileData      = 'pos';
            end
            
            switch lower(Args.Object)
                case 'tar'
                    % gzip tar file
                    FileName = sprintf('%s_%s_m%s_p%s_%s.tar.gz', Args.Version, Args.TimeScale, Args.TimePeriod, Args.TimePeriod, Args.FileType);
                otherwise
                    % planet
                    % inpop21a_TDB_m100_p100_asc_pos_Plu.asc
                    FileName = sprintf('%s_%s_m%s_p%s_%s_%s_%s.%s', Args.Version, Args.TimeScale, Args.TimePeriod, Args.TimePeriod, Args.FileType, Args.FileData, Args.Object(1:3), Args.FileType);
            end
        end
        
        function download(Args)
            % Download INPOP planetary ephemerides files
            % Input  : * ...,key,val,...
            %            'Location' - Location in which to download the
            %                   files. Default is '~/matlab/data/SolarSystem/INPOP/'.
            %            'Untar' - Untar downloaded files. Default is true.
            %            'URL' - A url of a specific file to download.
            %                   If empty, then use other argumntes to select
            %                   file to download. Default is [].
            %            'Version' - Default is 'inpop21a'.
            %            'TimeScale' - ['TDB'] | 'TCB'.
            %            'FileType' - Default is 'asc'.
            %            'Object' - Default is 'planets'.
            %            'TimePeriod' - ['100'] | '1000'.
            % Author : Eran Ofek (Apr 2022)
            % Example: celestial.INPOP.download
            
            arguments
                Args.Location      = '~/matlab/data/SolarSystem/INPOP/';
                Args.Untar logical = true;
                Args.URL           = [];
                Args.Version       = 'inpop21a';
                Args.TimeScale     = 'TDB';   % 'TDB' | 'TCB'
                Args.FileType      = 'asc';
                Args.Object        = 'planets';
                Args.TimePeriod    = '100';    % '100' | '1000'
            end
            
            Base = 'https://ftp.imcce.fr/pub/ephem';
            
            if ~isempty(Args.URL)
                % download specific file requested by user
                URL = Args.URL;
            else
                FileName = celestial.INPOP.inpopFileName('Object','tar', 'Version',Args.Version, 'TimeScale',Args.TimeScale, 'FileType',Args.FileType, 'TimePeriod', Args.TimePeriod);
                
                URL = sprintf('%s/%s/%s/%s',Base, Args.Object, Args.Version, FileName);
                % examples
                % https://ftp.imcce.fr/pub/ephem/planets/inpop21a/inpop21a_TDB_m100_p100_asc.tar.gz
                % https://ftp.imcce.fr/pub/ephem/planets/inpop21a/inpop21a_TCB_m100_p100_asc.tar.gz
                % https://ftp.imcce.fr/pub/ephem/planets/inpop21a/inpop21a_TDB_m1000_p1000_asc.tar.gz
                % https://ftp.imcce.fr/pub/ephem/planets/inpop21a/inpop21a_TCB_m1000_p1000_asc.tar.gz
            end
            
            PWD = pwd;
            mkdir(Args.Location)
            cd(Args.Location)
            [~,~,FileName] = www.wget(URL, 'OutputFile',[]);
            if Args.Untar
                pause(20);
                untar(FileName);
            end
            cd(PWD);
            
        end
        
        function Result = loadIAsciiINPOP(Args)
            % Load an ASCII INPOP ephmerides file
            %   The loaded file contains columns with:
            %       JDstart JDend Chebyshev coef. for the object position
            %       between JDstart and JDend.
            % Input  : * ...,key,val,...
            %            'Object' - Object name. If 'tar' then return the
            %                   tar file name.
            %                   Otherwise, this is a planet name.
            %            'Location' - Locaion in which the INPOP data files
            %                   are located.
            %                   Default is '~/matlab/data/SolarSystem/INPOP/'
            %            'FileData' - ['pos'] | 'vel'.
            %            'Version' - Default is 'inpop21a'.
            %            'TimeScale' - ['TDB'] | 'TCB'.
            %            'FileType' - Default is 'asc'.
            %            'TimePeriod' - ['100'] | '1000'.
            % Output : - A matrix containing the requested data file.
            %            Containing columns with:
            %            JDstart JDend Chebyshev coef. for the object position
            %            between JDstart and JDend.
            % Author : Eran Ofek (Apr 2022)
            % Example: R = celestial.INPOP.loadIAsciiINPOP('Object','Sun');
            
            arguments
                Args.Object        = 'Sun';
                Args.Location      = '~/matlab/data/SolarSystem/INPOP/';
                Args.Version       = 'inpop21a';
                Args.TimeScale     = 'TDB';   % 'TDB' | 'TCB'
                Args.FileType      = 'asc';
                Args.TimePeriod    = '100';    % '100' | '1000'
                Args.FileData      = 'pos';
            end
            
            FileName    = celestial.INPOP.inpopFileName('Object', Args.Object, 'Version',Args.Version, 'TimeScale',Args.TimeScale, 'FileType',Args.FileType, 'TimePeriod',Args.TimePeriod, 'FileData',Args.FileData);
            FullFileName = sprintf('%s%s%s',Args.Location, filesep, FileName);
            
            Result = readmatrix(FullFileName, 'NumHeaderLines',2,'FileType','text');
            
        end
        
    end
        
    methods(Static) % Unit test

        Result = unitTest()
            % unitTest for OrbitalEl class
    end

end