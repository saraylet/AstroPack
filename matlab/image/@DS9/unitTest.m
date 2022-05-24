function Result = unitTest()
	% unitTest for DS9
    
	io.msgStyle(LogLevel.Test, '@start', 'ds9 test started');
     
	if ~isunix && ~ismac
		io.msgStyle(LogLevel.Test, 'red', 'ds9 - Windows is not supported yet !!!');
        Result = false;
        return;
    end
    
    % create a DS9 object
    D = DS9;
    D.exit;
    D = DS9(rand(100,100),1);
    % open a window
    D.open
    % open another window
    D.open(true);
    D.exit
    % open again
    D.open(true);
    D.isOpen
    D.isWindowExist
    D.isOpen
    [Result,AllMethods] = DS9.getAllWindows;
    D.mode([]) 
    
    % switch ds9 window
    D.Frame=1;
    D.Frame=2;
    pause(0.5)
    if D.nframe~=2
        error('Number of frames suppose to be 2');
    end
    R = D.frame('delete'); % delete current frame
    if D.Frame~=1
        error('Frame number was supposed to be 1');
    end
    
    R = D.frame('center') % center current frame
    R = D.frame('clear') % clear current frame
    R = D.frame('new') % create new frame
    R = D.frame('new rgb') % create new rgb frame
    R = D.frame('reset') % reset current frame
    R = D.frame('refresh') % refresh current frame
    R = D.frame('hide') % hide current frame
    R = D.frame('first') % goto first frame
    R = D.frame('prev') % goto previous frame
    R = D.frame('last') % goto last frame
    R = D.frame('next') % goto next frame
    R = D.frame('match wcs') % 
    R = D.frame('lock wcs') % 
    
    D.clearFrame(2);
    D.clearFrame('all');
   
    D.frame('new');
    D.frame('new');
    D.frame('new');
    D.deleteFrame(2)
    D.deleteFrame('all');
    
    % xpasetFrame
    D = DS9(rand(100,100),1);
    D.load(rand(200,200),2)
    D.xpasetFrame(true,'zoom to 2')
    D.xpasetFrame(true,'zoom to 4')
    
    % zoom
    D.exit
    D.load(rand(100,100));
    FN = D.save2fits;
    delete(FN);
    
    D = DS9(rand(100,100),1);
    D.load(rand(100,100),2);
    D.zoom(5)
    D.zoom(-0.5)
    D.zoom(4,true)
    D.zoom   % zoom to fit
    D.zoom('to 5')
    D.zoom('in')
    D.zoom('out',2)
    
    % scale
    D = DS9(rand(100,100));
    [L,ST] = D.scale;
    D.scale([0 0.5]);
    
    % cmapInvert
    D.cmapInvert
    
    % colorbar control
    D.colorbar
            
    
    
	io.msgStyle(LogLevel.Test, '@passed', 'ds9 test passed');
	Result = true;
end