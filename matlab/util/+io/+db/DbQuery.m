% DbQuery
%
% https://www.tutorialspoint.com/java-resultset-movetoinsertrow-method-with-example
%--------------------------------------------------------------------------
% Use unittest__tables from GDrive to test
%

classdef DbQuery < Component
    
    % Properties
    properties (SetAccess = public)            
        
        % Connection details
        ConnectionStr = ''
        Conn = []
        
        % Current SQL statement data
        SqlText = ''        % SQL text
        Statement = []      % Prepared statement object
        
        ResultSet = []      % Returned result-set
        Record = []         % Current record
        Metadata = []        
        ColumnCount = 0     %
        ColumnNames  = []   %
        ColumnType  = []    %
        IsOpen = false      %
        Eof = true          %
        
    end
    
    %-------------------------------------------------------- 
    methods
        % Constructor    
        function Obj = DbQuery(varargin)
            
            Obj.needUuid();
            Obj.msgLog(LogLevel.Debug, 'DbQuery created: %s', Obj.Uuid);
            
            if numel(varargin) == 1
                Conn = varargin{1};
            elseif numel(varargin) == 0
                Conn = io.db.DbConnection.getDbConnection('');
            else
                error('DbQuery: Unknown parameters');
            end

            Obj.DebugMode = true;
            Obj.Conn = Conn;
        end
        
        
        % Destructor
        function delete(Obj)
            Obj.msgLog(LogLevel.Debug, 'DbQuery deleted: %s', Obj.Uuid);
        end                        
    end
    
    
    methods % open, close
                               
        function Result = open(Obj, varargin)
            %
            Obj.msgLog(LogLevel.Info, 'DbQuery: open');            
            
            % Need connection
            if isempty(Obj.Conn)
                error('DbQuery.open: No connection');
            end
               
            % Open connection
            if ~Obj.Conn.IsOpen
                Obj.Conn.open();
                if ~Obj.Conn.IsOpen
                    error('DbQuery.open: Open connection failed');
                end
            end            
            
            % Clear current query
            if Obj.IsOpen
                Obj.clear();
            end
            
            % Set SQL text
            if numel(varargin) == 1
                Obj.SqlText = varargin{1};
            end
                
            % Prepare query
            Obj.msgLog(LogLevel.Debug, 'DbQuery.open: %s', Obj.SqlText);
            try
                Obj.Statement = Obj.Conn.Conn.prepareStatement(Obj.SqlText);            
            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.open: prepareStatement failed: %s', Obj.SqlText);
            end
            
            % Execute 
            try
                Obj.ResultSet = Obj.Statement.executeQuery();
            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.open: executeQuery failed: %s', Obj.SqlText);
            end
            
            % Get metadata (@Todo: Make it Optional?)
            Obj.getMetadata();
            
            %
            Obj.next();
        end
        
        
        function Result = clear(Obj)
            Obj.clearResultSet();
            if ~isempty(Obj.ResultSet)
                Obj.ResultSet.close();
                Obj.Statement.close();
                Obj.clearResultSet();
                Obj.IsOpen = false;
            end
            Result = ~Obj.IsOpen;
        end
        
        
        function Result = close(Obj)
            Result = Obj.clear();
        end
        
        
        function Result = getMetadata(Obj)
            %
            Obj.ColumnCount = 0;
            Obj.ColumnNames = {};
            Obj.ColumnType = {};
            
            Result = false;
            try
                Obj.Metadata = Obj.Statement.getMetaData();
            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.open: getMetaData failed: %s', Obj.SqlText);
            end            

            try
                % http://docs.oracle.com/javase/7/docs/api/java/sql/Types.html
                Obj.ColumnCount = Obj.Metadata.getColumnCount();
                Obj.msgLog(LogLevel.Debug, 'DbQuery.getMetadata: ColumnCount = %d', Obj.ColumnCount);
                %data = cell(0, Obj.ColumnCount);
                for ColIndex = Obj.ColumnCount : -1 : 1
                    Obj.ColumnNames{ColIndex} = char(Obj.Metadata.getColumnLabel(ColIndex));
                    Obj.ColumnType{ColIndex}  = char(Obj.Metadata.getColumnClassName(ColIndex));  
                end
                
                % Remove 'java.lang.' frm field types, leave 'Double' etc.
                Obj.ColumnType = regexprep(Obj.ColumnType, '.*\.',''); 
                Result = true;

            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.open: getMetaData failed: %s', Obj.SqlText);
            end            

        end
        

        function Result = clearResultSet(Obj)
            % Clear current ResultSet
            
            Obj.ResultSet = [];
            Obj.Record = [];
            Obj.Metadata = [];        
            Obj.ColumnCount = 0;
            Obj.ColumnNames  = [];
            Obj.ColumnType  = [];
            Result = true;
        end
        

        function select(Obj, Fields, TableName, Args)
            % Execute: SELECT Fields FROM TableName
            
            arguments 
                Obj
                Fields
                TableName
                Args.Where = ''
                Args.Order = ''
                Args.Limit = -1
            end
            
            % Select
            Obj.SqlText = sprintf('SELECT %s FROM %s', Fields, TableName);
            
            % Where
            if ~isempty(Args.Where)
                Obj.SqlText = [Obj.SqlText, ' WHERE ', Args.Where];
            end
            
            % Order
            if ~isempty(Args.Order)
                Obj.SqlText = [Obj.SqlText, ' ORDER BY ', Args.Order];
            end
            
            % Limit            
            if Args.Limit > -1
                Obj.SqlText = [Obj.SqlText, ' LIMIT ', string(Args.Limit).char];
            end
            
            % Open
            Obj.open();            
        end
        
        
        function selectWhere(Obj, Fields, TableName, Where)
            % Execute: SELECT Fields FROM TableName WHERE Where
            Obj.SqlText = sprintf('%s FROM %s WHERE %s', Fields, TableName, Where);
            Obj.open();            
        end
        
        function exec(Obj, QueryText)
            % Execute query text
            
            Obj.SqlText = QueryText;
            
            Obj.Statement = Obj.Conn.prepareStatement(Obj.SqlText);
            
            Obj.ResultSet = Obj.Statement.executeQuery();
            
        end 
        
        
        function Result = next(Obj)
            Result = false;
            Obj.Eof = true;
            try
                Obj.Eof = ~Obj.ResultSet.next();
                Result = ~Obj.Eof;
            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.next failed');
            end                
        end
        
        
        function Result = prev(Obj)
            Result = false;
            Obj.Eof = true;
            try
                Obj.Eof = ~Obj.ResultSet.previous();
                Result = ~Obj.Eof;
            catch
                Obj.msgLog(LogLevel.Error, 'DbQuery.prev failed');
            end                
        end        
        
            
        function Result = getField(Obj, FieldName)
            % Get string field
            
            if isnumeric(FieldName)
                ColIndex = FieldName;
            else
                ColIndex = Obj.getFieldIndex(FieldName);
            end
                
            if ColIndex > 0
                try 
                    Type = Obj.ColumnType{ColIndex};
                    
                    switch Type
                        case { 'Float', 'Double' }
                            Result = Obj.ResultSet.getDouble(ColIndex);
                        case { 'Long', 'Integer', 'Short', 'BigDecimal' }
                            Result = double(Obj.ResultSet.getDouble(ColIndex));
                        case 'Boolean'
                            Result = logical(Obj.ResultSet.getBoolean(ColIndex));
                        case 'String'
                            Result = char(Obj.ResultSet.getString(ColIndex));
                        otherwise % case { 'Date', 'Time', 'Timestamp' }
                            Result = char(Obj.ResultSet.getString(ColIndex));
                    end
                    if Obj.DebugMode
                        Obj.msgLog(LogLevel.Debug, 'getField %s = %s', string(FieldName).char, string(Result).char);
                    end
                    
                catch
                    Obj.msgLog(LogLevel.Error, 'getField failed: %s', string(FieldName).char);
                end
            end
        end
        
        
        function Result = isField(Obj, FieldName)        
            % Check if field exists
            
            if isempty(Obj.ResultSet)
                Obj.msgLog(LogLevel.Error, 'Query is not open (ResultSet is empty)');
                Result = '';
            else
                try 
                    if ~isempty(Obj.Metadata)
                        Index = getFieldIndex(FieldName);
                        Result = (Index > 0);
                    else
                        Result = Obj.ResultSet.getString(FieldName);
                        Result = true;
                    end
                catch
                    Obj.msgLog(LogLevel.Error, 'Field not found: %s', FieldName);
                end
            end
        end
        
        
        function Result = getFieldIndex(Obj, FieldName)
            % Get field index in ColumnNames{}
            
            Result = find(strcmp(Obj.ColumnNames, FieldName));
        end
         
        
        function Result = getFieldType(Obj, FieldName)
            % Get field type
            
            if isnumeric(FieldName)
                Index = FieldName;
            else
                Index = Obj.getFieldIndex(FieldName);
            end
                
            if Index > 0                
                Result = Obj.ColumnType{Index};
            else
            end
        end  
                    
    end
    
    
    methods

                    
                    
        function Result = newRecord(Obj)
            % Create new empty record associated with this query
            
            Result = io.db.DbQuery(Obj);
        end
        
        
        function Result = getRecord(Obj)
            % Get current record from ResultSet as DbRecord
            
            % Create new record object
            Rec = io.db.DbRecord(Obj);
            
            % Loop over all columns in the row
            for ColIndex = 1 : Obj.ColumnCount
                
                FieldName = Obj.ColumnNames{ColIndex};
                Value = Obj.getField(ColIndex);                           
                addprop(Rec, FieldName);
                Rec.(FieldName) = Value;
            end
            
            Result = Rec;        
                        
        end
        
        
        function Result = insertRecord(Obj, Rec)
            % Insert new record
            Result = false;
            
            %
%             x = 1;
% 
%             for i=1:10
%                 pk = ['pk_', string(i).char];
%                 sql = 'INSERT INTO raw_images(ImageID, RA_Center) VALUES(%s,%s);'
% 
%                 Obj.Statement = Obj.Conn.prepareStatement(sql);            
%                 Obj.ResultSet = Obj.Statement.executeQuery();                
%             end
            
            
        end
        
        
        function Result = updateRecord(Obj, Rec)
            % Update record
            Result = false;
        end        
        
        
        function Result = loadAll(Obj, Args)
            % Load entire ResultSet to memory, might be time/memory consuming!
            % @Todo?: add arg max row
            % @Todo: load to Table (instead?)
            
            arguments
                Obj
                Args.MaxRecords = 0
            end
            
            FL_ = io.FuncLog('loadAll');
            
            % Initialize
            Obj.msgLog(LogLevel.Debug, 'DbQuery.loadAll, ColumnCount = %d', Obj.ColumnCount);
            Result = cell(0, Obj.ColumnCount);
            
            % Loop over all ResultSet rows (records)
            RowIndex = 1;
            while ~Obj.Eof
                
                % Loop over all columns in the row
                for ColIndex = 1 : Obj.ColumnCount
                    Value = Obj.getField(ColIndex);
                    Result{RowIndex, ColIndex} = Value;
                end
                
                if ~Obj.next()
                    break
                end
                
                if Args.MaxRecords > 0 && RowIndex > Args.MaxRecords
                    break
                end
                
                RowIndex = RowIndex + 1;                
            end         
            
            Obj.msgLog(LogLevel.Debug, 'DbQuery.loadAll, RowCount = %d', RowIndex);
        end
    end

    
    methods(Static)
    end
    
    
    %----------------------------------------------------------------------
    % Unit test
    methods(Static)
        function Result = unitTest()
            io.msgStyle(LogLevel.Test, '@start', 'DbQuery test started')
               
            % Create database connection
            %Conn = io.db.DbConnection;
            %Conn.DatabaseName = 'unittest';
            %Conn.open();

            Conn = io.db.Db.getUnitTest();
            
            % Query Postgres version
            
            %print('PostgreSQL database version:')
            %cur.execute('SELECT version()')
    
            % Select two fields from table
            Q = io.db.DbQuery(Conn);
            Q.open('select RecId, FInt from master_table limit 5');
            assert(Q.ColumnCount == 2);
            
            %
            Rec = Q.getRecord();
            B = Q.loadAll();
            
            % Load entire result set to memory
            Data = Q.loadAll();
            assert(size(Data, 2) == 2);
            
            % Select all fields from table
            Q.open(['select * from master_table limit 10']);
            
            % Load current record to memory
            Rec = Q.getRecord();
            
            % Get all fields, show not throw exception as all these fields
            % exist in table 'master_table'
            RecID = Rec.recid;
            InsertTime = Rec.inserttime;
            UpdateTime = Rec.updatetime;
            FInt = Rec.fint;
            FBigInt = Rec.fbigint;
            FBool = Rec.fbool;
            FDouble = Rec.fdouble;
            FTimestamp = Rec.ftimestamp;
            FString = Rec.fstring;

            % Test select function
            % select RecId, FInt, FBigInt from master_table where recid != ''
            Q.select('RecID, Fint', 'master_table', 'where', 'Fint > 0');
            Rec = Q.getRecord();
            
            % Insert records            
            % sql = 'INSERT INTO master_table(RecID, InsertTime, UpdateTime, FInt, FBigInt, FBool, FDouble, FTimestamp, FString) VALUES(%s,%s);'
            for i = 1:100
            end
            

            
            %assert(Rec.ColumnCount > 0);
            
            
            % Test: Create database and tables
            
            % Test: Write data to tables
            
            % Test: Query tables         
            
 
            io.msgStyle(LogLevel.Test, '@passed', 'DbQuery test passed')
            Result = true;
        end
    end    
        
    
end

