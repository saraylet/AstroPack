
function Result = unitTest()
    % FileProcessor.unitTest
    
    io.msgLog(LogLevel.Test, 'FileProcessor test started');

    InputPath = 'c:/soc/snr/input';

    % Create objcet
    fp = FileProcessor('InputPath', InputPath, 'InputMask', '*.json');
    fp.ProcessFileFunc = @fileProcessorCallback;

    % Input loop will call FileProcessorCallback (below) for each input
    % file found in the folder
    fp.process('DelaySec', 0.1);
    
    io.msgStyle(LogLevel.Test, '@passed', 'FileProcessor test passed');                          
    Result = true;
end

%------------------------------------------------------------------------

function Result = processItem(item)
    % Process item, return result
    % See ultrasat.git/python/prj/src/webapps/webapp_snr/rest_snr_server1.py
    
    % Input   : - item - struct Item with op, x, y fields

    %           * Pairs of ...,key,val,...
    %             The following keys are available:            			            

    %                      
    % Output  : struct ResponseMessage with message, result fields
    % Author  : Chen Tishler (2021)
    % Example : 
    
    % Item 
    % ResponseMessage
    
    % Prepare output
    out = struct;
    out.message = 'MATLAB: Exception in processItem';
    out.result = -1;   
  
    try
        out.message = sprintf('MATLAB: op: %s', item.op);
        
        if strcmp(item.op, 'add')
            out.result = item.x + item.y;
        elseif strcmp(item.op, 'mul')
            out.result = item.x * item.y;
        elseif strcmp(item.op, 'sub')
            out.result = item.x - item.y;
        elseif strcmp(item.op, 'div')
            if item.y ~= 0
                out.result = item.x / item.y;
            else
                ME = MException('SNR:process', 'Division by zero');
                throw(ME);
            end
        elseif strcmp(item.op, 'snr')            
            out = processSnr(item.json_text);
        else
            strcpy(out.message, 'MATLAB: unknown op');
        end
    catch Ex
        out.message = sprintf('MATLAB: exception: %s', Ex.message);
    end
    
    Result = out;
end

%------------------------------------------------------------------------

function fileProcessorCallback(FileName)
    io.msgLog(LogLevel.Info, 'FileProcessorCallback started: %s', FileName);
      
    TmpFileName = strcat(FileName, '.out.tmp');
    OutFileName = strcat(FileName, '.out');

    % Read input JSON file
    fid = fopen(FileName);
    raw = fread(fid, inf);
    str = char(raw');
    fclose(fid);
    
    % Parse JSON from string to struct
    io.msgLog(LogLevel.Info, 'JSON: %s', str);
    item = jsondecode(str);
   
    % Process
    try
        out = processItem(item);
    catch Ex
        out = struct;
        out.message = sprintf('MATLAB: Exception calling processItem: %s', Ex.message);        
        out.result = -1;           
    end

    % Write output JSON file
    io.msgLog(LogLevel.Info, 'Out.message: %s, result: %s', out.message, out.result);
    out_json = jsonencode(out);
    fid = fopen(TmpFileName, 'wt');
    fprintf(fid, out_json);
    fclose(fid);

    % Rename final file to output extension
    try
        io.msgLog(LogLevel.Info, 'Rename output %s -> %s', TmpFileName, OutFileName);
        movefile(TmpFileName, OutFileName);
    catch
    end
end

%------------------------------------------------------------------------

function Result = processSnr(json_text)
    % Process SNR
    % See ultrasat.git/python/prj/src/webapps/webapp_snr/rest_snr_server1.py
    
    % Input   : - snr - struct 

    %                      
    % Output  : struct ResponseMessage with fields: message, result
    % Author  : Chen Tishler (2022)
    % Example : 
    
    % Decode text
    snr = jsondecode(json_text);
            
    out = struct;
    out.message = sprintf('MATLAB: processSnr started');
    out.result = -1;
    
    % Do the actual SNR processing here
    %
    %
    
    % Done
    out.message = sprintf('MATLAB: processSnr completed: R: %s', snr.R);
    out.result = 777;    
    
    Result = out;
end

