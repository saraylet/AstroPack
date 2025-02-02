function [Data, Ephem]=getJPL_CloseApproachNEO(Args)
    % Get list of NEO close approaches to Earth along with their JPL ephemeris
    % Input  : * ...,key,val,...
    %            'MinJD' - Min JD for which to search close approaches.
    %                   Default is today - 3 days.
    %            'MaxJD' - Max JD. Default is today + 3 days.
    %            'MaxDist' - Default is 10.
    %            'DistUnits' - Default is 'LD' (lunar dist.).
    %            'GeodCoo' - Default is [35.0407331, 30.0529838 0.4154]
    %            'StepSizeUnits' - Default is 'h'.
    % Output : - A list of close approach NEOs
    %          - An AstroCatalog object with ephemeris for each NEOs
    %            in the close approach list.
    %            The object name is stored in the AstroCatalog Name
    %            property.
    %            'UserData' contains min mag over period.
    % Author : Eran Ofek (Oct 2023)
    % Example: [Data,Ephem]=celestial.SolarSys.getJPL_CloseApproachNEO

    arguments
        Args.MinJD       = celestial.time.julday - 3;
        Args.MaxJD       = celestial.time.julday + 3;
        Args.MaxDist     = 10;
        Args.DistUnits   = 'LD';
        Args.GeodCoo     = [35.0407331, 30.0529838 0.4154];
        Args.StepSizeUnits = 'h';
    end

    
    MinDate = datetime(Args.MinJD,'convertfrom','juliandate','format','yyyy-MM-dd');
    MaxDate = datetime(Args.MaxJD,'convertfrom','juliandate','format','yyyy-MM-dd');


    StrURL = sprintf('https://ssd-api.jpl.nasa.gov/cad.api?dist-max=%d%s&date-min=%s&date-max=%s', Args.MaxDist, Args.DistUnits, MinDate, MaxDate);


    Data   = webread(StrURL);

    if Data.count>0
        if nargout>1
            N = numel(Data.data);
            for I=1:1:N
                Name = Data.data{I}{1}
                Ephem(I) =celestial.SolarSys.jpl_horizons('ObjectInd',Name,'StartJD',Args.MinJD,'StopJD',Args.MaxJD, 'GeodCoo',Args.GeodCoo, 'StepSizeUnits',Args.StepSizeUnits);
                Ephem(I).Name = Name;
                Ephem(I).UserData = min(Ephem(I).Catalog(:,4));
            end

        end
    else
        Ephem = [];
    end

end