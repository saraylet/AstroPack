% Functions and Classes list for the imProc package
% Author : autogenerated (May 2022)
%              imProc.allFunList - Functions and Classes list for the imProc package
%    imProc.asteroids.allFunList - Functions and Classes list for the imProc.asteroids package
% imProc.asteroids.prepMPC_report - 
% imProc.asteroids.searchAsteroids_matchedOrphans - 
% imProc.asteroids.searchAsteroids_orphans - 
% imProc.asteroids.searchAsteroids_pmCat - Search asteroids in merged AstroCatalog objects which contains proper motion
% imProc.astrometry.addCoordinates2catalog - Add or update RA/Dec coordinates in catalogs in AstroImage/Astrocatalog
%   imProc.astrometry.allFunList - Functions and Classes list for the imProc.astrometry package
% imProc.astrometry.assessAstrometricQuality - Collect information regarding quality of astrometric solution and
% imProc.astrometry.astrometryCheck - Compare the astrometry of a catalog with a reference astrometric catalog.
% imProc.astrometry.astrometryCore - A core function for astrometry. Match pattern and fit transformation.
% imProc.astrometry.astrometryCropped - Execute astrometry on a section of a full image.
% imProc.astrometry.astrometryImage - 
% imProc.astrometry.astrometryRefine - Refine an astrometric solution of an AstroCatalog object
% imProc.astrometry.astrometrySubImages - Solve astrometry for sub images of a single contigious image
%       imProc.astrometry.fitWCS - Perform the Tran2D.fitAstrometricTran and prepare the WCS info
%     imProc.astrometry.unitTest - unitTest for +imProc.astrometry
%   imProc.background.allFunList - Functions and Classes list for the imProc.background package
%   imProc.background.background - Calculate background and variance of an AstroImage object.
% imProc.background.filterSources - Generate a background image filtered from sources using sucessive filtering
%   imProc.background.fitSurface - Fit a surface to a 2D image, with sigma clipping
% imProc.background.subtractMeanColRow - Subtract the collapsed median of rows and columns from an AstroImage.
%     imProc.background.unitTest - unitTest for the +imProc.background package
%        imProc.calib.allFunList - Functions and Classes list for the imProc.calib package
%       imProc.calib.gainCorrect - Divide image by gain and update header.
%     imProc.calib.photometricZP - Calculate an absolute photometric calibration to AstroCatalog
% imProc.calib.selectMainSequenceFromGAIA - Select main sequence stars from GAIA catalog in AstroCatalog object.
%          imProc.calib.unitTest - unitTest for imProc.calib
%       imProc.calib.CalibImages - CalibImages class - A class for storing calibration image, and performs
%          imProc.cat.allFunList - Functions and Classes list for the imProc.cat package
%   imProc.cat.applyProperMotion - Apply proper motion and parallax to sources in AstroCatalog object
% imProc.cat.filterForAstrometry - Given two catalogs, match their surface density and filter sources.
% imProc.cat.fitPeakMultipleColumns - Given N columns with some property (e.g., S/N) fit a parabola
% imProc.cat.getAstrometricCatalog - Get Astrometric catalog from local/external database
%         imProc.cat.insertAzAlt - Calculate and insert Az, Alt, AirMass, ParAng columns to AstroCatalog object
%      imProc.cat.insertImageVal - Insert Image values at specific positions into an AstroCatalog
%            imProc.cat.unitTest - unitTest for imProc.cat
%         imProc.dark.allFunList - Functions and Classes list for the imProc.dark package
%               imProc.dark.bias - Generate a super bias image from a s et of bias images.
%   imProc.dark.compare2template - Compare AstroImage to a template and variance and flag image
%             imProc.dark.debias - Subtract bias (and construct if needed) from a list of images
% imProc.dark.draft_UnitTest_Check - Draft
% imProc.dark.identifyFlaringPixels - Identify flaring pixels in a cube of images
% imProc.dark.identifySimilarImages - Search for sucessive images with a fraction of identical pixel values
%             imProc.dark.isBias - Check and validate that a set of images in an AstroImage object are bias images
%             imProc.dark.isDark - Check and validate that a set of images in an AstroImage object are dark images
%           imProc.dark.overscan - Create overscan images and optionally subtract from images
%           imProc.dark.unitTest - unitTest for +dark
%         imProc.flat.allFunList - Functions and Classes list for the imProc.flat package
%             imProc.flat.deflat - Divide by flat (and construct if needed) from a list of images
%               imProc.flat.flat - Generate a super flat image from a set of flat images.
%             imProc.flat.isFlat - Check and validate that a set of images in an AstroImage object are flat images
%           imProc.flat.unitTest - unitTest for imProc.flat
%        imProc.image.allFunList - Functions and Classes list for the imProc.image package
%           imProc.image.cutouts - Break a single image to a cube of cutouts around given positions
%   imProc.image.image2subimages - Partition an AstroImage image into sub images
%       imProc.image.images2cube - Convert the images in AstroImage object into a cube.
%     imProc.image.interpOverNan - interpolate AstroImage over NaN values
%  imProc.image.replaceWithNoise - Replace selected pixels with (global) noise and background
%          imProc.image.unitTest - unitTest for the +imProc.image package
%     imProc.image.obsolete.Dark - imProc.image.Dark class
%     imProc.image.obsolete.Flat - 
%    imProc.image.obsolete.Stack - obsolete:
% imProc.image.obsolete.allFunList - Functions and Classes list for the imProc.image.obsolete package
%    imProc.instCharc.allFunList - Functions and Classes list for the imProc.instCharc package
%  imProc.instCharc.gainFromFlat - Estimate the gain from flat image/s in native units.
%     imProc.instCharc.linearity - Estimate the non-linearity of a detector
% imProc.instCharc.readNoiseFromBias - Estimate the read noise from bias mage/s in native units.
%      imProc.instCharc.unitTest - unitTest for imProc.instCharc
%         imProc.mask.allFunList - Functions and Classes list for the imProc.mask package
% imProc.mask.interpOverMaskedPix - Interpolate over pixels with specific bit mask
%             imProc.mask.maskCR - 
%          imProc.mask.maskHoles - Search for holes in images and add a bit mask marking the hole central position.
%      imProc.mask.maskSaturated - set mask bits for saturated and non-linear pixels
%    imProc.mask.maskSourceNoise - Mask pixels which are dominated by source noise (rather than background noise).
% imProc.mask.replaceMaskedPixVal - Replace the values of image pixels which have specific bit mask
%           imProc.mask.unitTest - unitTest for +imProc.mask
%        imProc.match.allFunList - Functions and Classes list for the imProc.match package
%        imProc.match.coneSearch - cone search(s) on AstroCatalog/AstroImage object
% imProc.match.flagSrcWithNeighbors - Flag sources in AstroCatalog which have neighbors within a radius
%         imProc.match.inPolygon - Return sources inside polygon
% imProc.match.insertColFromMatched_matchIndices - Given two catalogs, matched them and insert some matched columns to the first catalog
% imProc.match.insertCol_matchIndices - Insert Dist/Nmatch columns to a single element AstroCatalog based on ResInd.
%             imProc.match.match - Match two catalogs in AstroCatalog objects
% imProc.match.match2solarSystem - Match sources in AstroCatalog object to Solar System objects.
% imProc.match.matchReturnIndices - Match two catalogs in AstroCatalog objects and return the matched indices.
%     imProc.match.match_catsHTM - Match an AstroCatalog object with catsHTM catalog
% imProc.match.match_catsHTM_multiInsertFlag - 
% imProc.match.match_catsHTMmerged - Match an AstroCatalog with the catsHTM MergedCat.
%    imProc.match.matched2matrix - A matched AstroCatalog object into a matrix of epochs by index
%  imProc.match.matchedReturnCat - Match AsstroCatalogs and return array of matched catalogs.
%     imProc.match.mergeCatalogs - Merge catalogs of the same field into a single unified merged catalog
% imProc.match.unifiedSourcesCatalog - Match multiple catalogs and create a catalog of all unique (by position) sources.
%          imProc.match.unitTest - unitTest for +imProc.match
%          imProc.psf.allFunList - Functions and Classes list for the imProc.psf package
%        imProc.psf.constructPSF - Select PSF stars and construct a PSF for an AstroImage
%                imProc.psf.fwhm - Measure the FWHM from the PSF in an AstroImage and write in Header.
%         imProc.psf.measureFWHM - Estimate image seeing or focus state
%            imProc.psf.psf2cube - Construct a cube of PSF stamps from AstroImage
%      imProc.psf.selectPsfStars - Select PSF stars from AstroCatalog
%      imProc.sources.allFunList - Functions and Classes list for the imProc.sources package
% imProc.sources.classifySources - Classify sources found by findMeasureSources.
%    imProc.sources.cleanSources - Clean sources found by findMeasureSources (bad S/N and CR).
% imProc.sources.findMeasureSources - Basic sources finder and measurments on AstroImage object.
%     imProc.sources.findSources - Find sources (only) in AstroImage using imUtil.sources.findSources
%      imProc.sources.psfFitPhot - Execute PSF photometry on a list of coordinates and add the results
%        imProc.stack.allFunList - Functions and Classes list for the imProc.stack package
%     imProc.stack.applyUnaryFun - Applay scalar-unary function (e.g., function that returns a scalar) on AstroImage
%             imProc.stack.coadd - Coadd images in AstroImage object including pre/post normalization
%   imProc.stack.coaddProperCore - Proper coaddition of images in AstroImage object
%      imProc.stack.divideFactor - Divide factor (constant) from AstroImage
%           imProc.stack.funCube - Apply function/s on a single cube
% imProc.stack.functionalResponse - Fit the pixel response to light as a function of intensity in a cube of images
%    imProc.stack.subtractOffset - Remove offset (constant) from AstroImage
%          imProc.stack.unitTest - unitTest for the Stack class
%         imProc.stat.allFunList - Functions and Classes list for the imProc.stat package
%               imProc.stat.hist - Plot the histogram of a single property in a single AstroImage object image.
%         imProc.stat.histcounts - Return the histcounts of a single property in a single AstroImage object image.
%  imProc.stat.identifyBadImages - Identify bad images based on simple statistical properties:
%                imProc.stat.max - Return the max of AstroImage object images.
%               imProc.stat.mean - Return the mean of AstroImage object images.
%             imProc.stat.median - Return the median of AstroImage object images.
%                imProc.stat.min - Return the min of AstroImage object images.
%               imProc.stat.mode - Return the mode of AstroImage object images using
%             imProc.stat.moment - Return the moment of AstroImage object images.
%           imProc.stat.quantile - Return the quantile of AstroImage object images.
%              imProc.stat.range - Return the range of AstroImage object images.
%               imProc.stat.rstd - Return the rstd (robust std) of AstroImage object images using
%                imProc.stat.std - Return the std of AstroImage object images.
%           imProc.stat.unitTest - unitTest for the +imProc.stat package
%                imProc.stat.var - Return the var of AstroImage object images.
%        imProc.trans.allFunList - Functions and Classes list for the imProc.trans package
%        imProc.trans.fitPattern - Match two catalogs using stars pattern and return approximate transformation
% imProc.trans.fitTransformation - Fit an exact transformation between two matched catalogs
%        imProc.trans.projection - project Lon/Lat to X/Y using specified projection
%     imProc.trans.projectionInv - project X/Y to Lon/Lat using specified projection
%        imProc.trans.tranAffine - Apply affine transformation to an AstroCatalog object
%          imProc.trans.unitTest - unitTest for +imProc.match
%      imProc.transIm.allFunList - Functions and Classes list for the imProc.transIm package
%          imProc.transIm.imwarp - Apply the imwarp function on AstroImage object
%      imProc.transIm.imwarp_old - Apply the imwarp function on AstroImage object
%        imProc.transIm.thoughts - 
%        imProc.transIm.unitTest - unitTest for +imProc.register package
% imProc.transIm.updateHeaderCCDSEC - Update the NAXIS and CCDSEC related keywords in the header
 help imProc.allFunList