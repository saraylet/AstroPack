function Result = tranAffine(Obj, AffineMatrix, IsForward, Args)
    % Apply affine transformation to an AstroCatalog object
    % Input  : - 
    % Example: Result = imProc.trans.tranAffine(rand(100,2), [1 1], true)
    

    arguments
        Obj
        AffineMatrix
        IsForward(1,1) logical  = true;
        
        Args.ColX               = AstroCatalog.DefNamesX;
        Args.ColY               = AstroCatalog.DefNamesY;
        
        Args.CreateNewObj       = [];
    end
    
    if isnumeric(Obj)
        Tmp = Obj;
        Obj = AstroCatalog;
        Obj.Catalog  = Tmp;
        Obj.ColNames = {'X','Y'};
        %Obj.ColUnits = Args.ColUnits;
    end
    
    if isempty(Args.CreateNewObj)
        if nargout==0
            Args.CreateNewObj = false;
        else
            Args.CreateNewObj = true;
        end
    end
    if Args.CreateNewObj
        Result = Obj.copyObject;
    else
        Result = Obj;
    end
    
    Nobj = numel(Obj);
    for Iobj=1:1:Nobj
        % for each element of AstroCatalog/AstroImage
        
        % get X/Y from catalog
        if isa(Obj, 'AstroCatalog')
            Cat = Result(Iobj);
        elseif isa(Obj, 'AstroImage')
            Cat = Result(Iobj).CatData;
        else
            error('Unknown catalog format');
        end
            
        [ColX]   = colnameDict2ind(Cat, Args.ColX);
        [ColY]   = colnameDict2ind(Cat, Args.ColY);
        [X] = getCol(Cat, ColX);
        [Y] = getCol(Cat, ColY);  
        
        % Perform Affine transformation
        if isa(AffineMatrix, 'affine2d')
            % do nothing - already a MATLAB affine2d object
            AffineMatrix = AffineMatrix.T;
        else
            if all(size(AffineMatrix)==[3 3])
                % Assume AffineTrans is a 3x3 matrix of forward affine
                % transformation
                
            else
                % Assume input is vector of parameters
                switch numel(AffineMatrix)
                    case 2
                        % [ShiftX, ShiftY]
                        ShiftX = AffineMatrix(1);
                        ShiftY = AffineMatrix(2);
                        Theta  = 0;
                        Scale  = 1;
                        FlipX  = 1;
                        FlipY  = 1;
                    case 3
                        % [ShiftX, ShiftY, Rotation]
                        ShiftX = AffineMatrix(1);
                        ShiftY = AffineMatrix(2);
                        Theta  = AffineMatrix(3);
                        Scale  = 1;
                        FlipX  = 1;
                        FlipY  = 1;
                    case 4
                        % [ShiftX, ShiftY, Rotation, Scale]
                        ShiftX = AffineMatrix(1);
                        ShiftY = AffineMatrix(2);
                        Theta  = AffineMatrix(3);
                        Scale  = AffineMatrix(4);
                        FlipX  = 1;
                        FlipY  = 1;
                    case 6
                        % [ShiftX, ShiftY, Rotation, Scale, FlipX, FlipY]
                        ShiftX = AffineMatrix(1);
                        ShiftY = AffineMatrix(2);
                        Theta  = AffineMatrix(3);
                        Scale  = AffineMatrix(4);
                        FlipX  = AffineMatrix(5);
                        FlipY  = AffineMatrix(6);
                    otherwise
                        error('Unknown Addine Transformation option');
                end
                AffineMatrix = [FlipX.*Scale.*cos(Theta), -FlipY.*Scale.*sin(Theta), ShiftX; FlipX.*Scale.*sin(Theta),  FlipY.*Scale.*cos(Theta), ShiftY; 0  0  1];
            end
            
        end
        
        % backward/forward transformation
        if ~IsForward
            AffineMatrix = AffineMatrix.';        
        end
        
        N = size(X,1);
        if N>0
            Z = ones(N,1);

            Coo    = [X,Y,Z];
            NewCoo = [AffineMatrix * Coo.'].';
            
            Result = replaceCol(Result, NewCoo(:,1:2), [ColX, ColY]);
            
        end
    end
    
end
