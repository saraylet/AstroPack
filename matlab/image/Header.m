% @Chen

% Configuration base Class
% Package: 
% Description:
%--------------------------------------------------------------------------

classdef Header < Component
    % Properties
    properties (SetAccess = public)
        Data(:,3) cell            = cell(0,3);
        Key struct                = struct(); 
        
        File                      = '';
        HDU                       = ''; % HDU or dataset
        
%         filename        
%         configPath = "";
%         data
%         lines
%         userData
%         
%         inputImagePath
%         inputImageExt
    end
    

    methods
        % Constructor    
        function obj = Header()
        end
    end
    
    methods % read/write
        function Obj=read(Obj,Args)
            % read as a single/multiple headers from file/s into an Header object
            % Input  : - An Header object
            %          * ...,key,val,... or ,key=val,...
            %            'FileName' - File name or a cell array of file
            %                   names. Default is to use Header.File
            %                   property.
            %            'HDU' - HDU (scalae or vector) or dataset. Default
            %                   is to use Header.HDU.
            %            'Type' - File type. 'fits'|'hdf5'|['auto'].
            %                   'auto' will attempt automatic
            %                   identificatin.
            % Examples: H=Header;
            % H.read('FileName',{'File1.fits','File2.fits'});  % read two headers in default HDU.
            % H.read('FileName','File1.fits','HDU',[1 2]); % read 2 HDUs from a single file
            
            arguments
                Obj
                Args.FileName      = Obj.File;
                Args.HDU           = Obj.HDU;
                Args.Type char {mustBeMember(Args.Type,{'auto','fits','fit','FITS','FIT','fit.gz','fits.gz','hdf5','h5','hd5'})} = 'auto';
            end
            
            if ~iscell(Args.FileName)
                Args.FileName = {Args.FileName};
            end
            Nfile = numel(Args.FileName);
            Nhdu  = numel(Args.HDU);
            Nmax  = max(Nfile,Nhdu);
            
            switch Args.Type
                case 'auto'
                    FileParts = split(FileName,'.');
                    Args.Type = FileParts{end};
            end
            
            switch lower(Args.Type)
                case {'fits','fit','fit.gz','fits.gz'}
                    % read FITS file
                    FO = FITS;
                    for Imax=1:1:Nmax
                        Ih    = min(Nhdu,Imax);
                        Ifile = min(Nfile,Imax);
                        Obj(Ifile).Data = FO.readHeader(Args.FileName{Ifile},Args.HDU(Ih));
                        Obj(Ifile).File = Args.FileName{Ifile};
                        Obj(Ifile).HDU  = Args.HDU(Ih);
                    end
                case {'hdf5','h5','hd5'}
                    % read hdf5 file
                    error('Read Header from HDF5 file is not available yet');
                otherwise
                    error('Unknown file Type option');
            end
            
            
            
        end
        
    end
    
    methods  % functions for internal use
        %
        
        
    end
    
    methods 
        function [Val,Key,Comment]=keyVal(Obj,KeySynonym,Args)
            %
            
            arguments
                KeySynonym char               = '';
                Args.CaseSens(1,1) logical    = true;
                Args.SearchType char {mustBeMember(Args.SearchType,{'strcmp','regexp'})} = 'strcmp';
                Args.Fill                                                       = NaN;
                Args.Val2Num(1,1) logical     = true;
                Args.UseDict(1,1) logical     = true;
            end
            
            if numel(Obj)>1
                error('Use mkeyVal for Header object with multiple entries or multiple keys');
            end
            
            % I need the dictionary in order to continue
            %[SC,FE,II] = imUtil.headerCell.getVal(Obj.Data,KeySynonym)
            
        end
        
        function mkeyVal(Obj,KeySynomym,Args)
            %
            
            arguments
                KeySynonym  {mustBeA(KeySynonym,{'char','cell'})}  = '';
                Args.CaseSens(1,1) logical    = true;
                Args.NotExist char  {mustBeMember(Args.NotExist,{'NaN','fail'})} = 'NaN';
                Args.Val2Num(1,1) logical     = true;
                Args.UseDict(1,1) logical     = true;
                Args.OutType char {musBeMember(Args.OutType,{'cell','Header'})} = 'cell';
            end
            
        end
        
        function Result=deleteKey(Obj,KeySynonym,Args)
            %
           
            arguments
                KeySynonym  {mustBeA(KeySynonym,{'char','cell'})}  = '';
                Args.CaseSens(1,1) logical    = true;
                Args.UseDict(1,1) logical     = true;
            end
            
        end
        
        function insertKey(Obj,KeyValComment,Args)
            %
            
            arguments
                Obj
                KeyValComment  {mustBeA(KeySynonym,{'char','cell'})}  = '';
                Args.Pos(1,1) double {mustBePositive(Args.Pos)}       = Inf;
            end
        
        end
        
        
        function replaceVal(Obj,Key,NewVal,Args)
            %
            arguments
                Obj
                Key    {mustBeA(Args.Key,{'char','cell'})} = '';
                NewVal                                     = ''; 
                NewComment                                 = '';
                NotExist char {mustBeMemeber(Args.NotExist,{'add','fail'})} = 'add'; 
            end
        end
        
        function search(Obj,Val,Args)
            %
            arguments
                Obj         
                Val                 
                Args.Column                  = 1;
                Args.CaseSens(1,1) logical   = true;
            end
        end
        
        
        function isKeyVal(Obj,Key,Val,Args)
            %
            arguments
                Obj
                Key    {mustBeA(Args.Key,{'char','cell'})} = '';
                Val                                        = [];
                LogicalOperator char {mustBeMemeber(Args.NotExist,{'and','or'})} = 'and'; 
                CaseSens(1,1) logical                      = true;
            end
        
        end
        
        % isKeyExist
        
        % julday
        
        % findGroups
        
        % getObsCoo
        
        % getCoo
        
    end
    
    
    % Unit test
    methods(Static)
        function result = uTest()
            fprintf("Started\n");
            conf = Config("c:/temp/conf.txt")
            val = conf.getValue("key1");
            disp(val);           
            num = conf.getNum("key3");
            disp(num);
            result = true;
        end
    end    
        
end


