function startup_LAST
    % startup for LAST directories

    Home   = char(java.lang.System.getProperty('user.home'));
    Base   = sprintf('%s%s%s%s%s',Home, filesep,'matlab',filesep, 'LAST');

    AllFiles = dir(Base);
    IsDir = [AllFiles.isdir];
    List = {AllFiles(IsDir).name};

    Nlist = numel(List);
    for Ilist=1:1:Nlist
        if ~(strcmp(List(1),'+') || strcmp(List(1),'@'))
            sprintf('%s%s%s',Base, filesep, List{Ilist})
            %addpath(sprintf('%s%s%s',Base, filesep, List{Ilist}));
        end
    end

end