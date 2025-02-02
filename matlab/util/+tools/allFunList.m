% Functions and Classes list for the tools package
% Author : autogenerated (Jun 2023)
%               tools.allFunList - Functions and Classes list for the tools package
%                 tools.unitTest - Package Unit-Test
%         tools.array.allFunList - Functions and Classes list for the tools.array package
%            tools.array.and_mat - Perform logical and operation between all the columns or rows of a matrix
%            tools.array.and_nan - Logical function "and" for NaNs.
%       tools.array.array_select - Select lines in an array which columns satisfay some criteria.
%        tools.array.assoc_range - Index of points in each bin.
%       tools.array.bitand_array - Perform a bitand operation along all elements in an array.
%        tools.array.bitor_array - Perform a bitor operation along all elements in an array.
%         tools.array.bitsetFlag - 
%        tools.array.blockmatrix - blockmatrix: reshape N-D matrix such that blocks of elements are adjacent
%          tools.array.bsx_nsize - bsx_nsize gets multiple of array sizes (i.e. result of the size function),
%           tools.array.bsx_size - bsx_size gets two arrays S1,S2 and calculates the size of the result
%        tools.array.check_range - Replace out of bound indices with bound indices.
%           tools.array.countVal - Given an N-D Array, count the number of elements
%         tools.array.delete_ind - Delete a column/s or row/s from a matrix.
%        tools.array.find_ranges - Indices of vector values found within one of several ranges.
%   tools.array.find_ranges_flag - Check if values are within some ranges.
%           tools.array.findmany - Find all values in a vector in another vector or matrix.
%       tools.array.flag2regions - Identify continous ranges of true values.
%        tools.array.hist2d_fast - A fast version of histcounts2 (without all the overheads)
%            tools.array.inRange - Check if values in array are within some ranges
%      tools.array.ind2sub_array - ind2sub_array Multiple subscripts from linear index.
%        tools.array.indexWindow - Return the in bound indices of a window in an array of some length.
%   tools.array.index_outofbound - Remove from vector of indices valu8es which are out of bounds.
%         tools.array.insert_ind - Insert a column/s or row/s to a specific position in a matrix.
%         tools.array.is_evenint - Check for each integer number in array if even.
%           tools.array.list2vec - Concatenate all vectors to a single vector.
%     tools.array.maskflag_check - --------------------------------------------------------------------------
%       tools.array.maskflag_set - --------------------------------------------------------------------------
%            tools.array.mat2vec - Convert matrix to vector. Use (:) instead.
%            tools.array.nan2val - Replace NaNs in an array with a specific values
%          tools.array.nangetind - Replace value with NaNs when index is out of bound.
%     tools.array.nearest_unflag - Nearest coordinate to an unflagged point.
%         tools.array.onesExcept - 
%             tools.array.or_nan - Logical function "or" for NaNs.
%            tools.array.replace - Replace values in specific range, or equal NaN, with another value.
%      tools.array.select_by_ind - Select lines by index, return NaN when index is NaN.
%      tools.array.sub2ind_array - sub2ind_array Linear index from multiple subscripts.
%       tools.array.sub2ind_fast - sub2ind fast version for 2D matrices
%          tools.array.sum_bitor - A bitor operation on all lines or rows and return a vector ofbit-wise or.
%               tools.array.trim - B = tools.array.trim(A, I1, I2, J1, J2)
%       tools.array.unique_count - Unique values and count the number of apperances of each value.
%           tools.array.unitTest - Package Unit-Test
%     tools.array.mex.allFunList - Functions and Classes list for the tools.array.mex package
% tools.array.mex.test_mex_bit_array32 - 
% tools.array.mex.test_mex_bit_array64 - 
%          tools.cell.allFunList - Functions and Classes list for the tools.cell package
%         tools.cell.cell2_equal - Check if two cell array have an identical content
%        tools.cell.cell2mat_nan - Convert numeric cell to matrix. Replace empty cells with NaNs.
%   tools.cell.cellNumericSuffix - Add a range of numeric suffix to a string and put result in a cell array.
%          tools.cell.cell_equal - Compare the content of a cell array to its first cell.
%    tools.cell.cell_find_groups - Find all cell lines with identical values, and return indices of groups.
%         tools.cell.cell_insert - Insert elements within a cell array.
%        tools.cell.cell_sprintf - sprintf on content in cell array
% tools.cell.cellstr2num_dictionary - Given a cell array of strings, repace unique strings by numeric index
%      tools.cell.cellstr_prefix - Add a prefix to all the strings in a char array.
%       tools.cell.group_cellstr - Find and group distinct values in a cell array.
%            tools.cell.ind_cell - Select indices of vectors in cell array of vectors.
%        tools.cell.isempty_cell - Check if each cell element is empty.
%          tools.cell.isnan_cell - Check if cell elemt is NaN.
% tools.cell.remove_cell_element - Remove a list of indices from a cell vector.
%   tools.cell.sort_numeric_cell - sort each row or columns in a cell array of numbers.
%        tools.cell.sprintf2cell - Generate a cell array of string using sprintf.
%  tools.cell.sprintf_concatCell - Concat a multiple cell arrays content into a string
%     tools.cell.strNameDict2ind - Search the first appearance of string in dictionary in another cell.
% tools.cell.unique_cell_grouping - Find unique lines in the cell matrix.
%            tools.cell.unitTest - Package Unit-Test
%      tools.checksum.allFunList - Functions and Classes list for the tools.checksum package
%        tools.checksum.unitTest - test_xxhash();
%          tools.checksum.xxhash - Compute xxHash value of given data or file.
%  tools.checksum.mex.allFunList - Functions and Classes list for the tools.checksum.mex package
%          tools.code.allFunList - Functions and Classes list for the tools.code package
%        tools.code.analyzeMfile - Analyze m files. Count lines of code, identify functions, help, authors etc.
% tools.code.breakClassToFunctions - Parse all functions from a class m file
%    tools.code.classifyAllFiles - Classify matlab-related files.
%        tools.code.fun_template - Generate a function file template
% tools.code.genPackage_allFunList - generate a file named allFunList in each subpackage containing the list of functions
% tools.code.generateFunListWebPage - Generate an html file with sortable table of all functions and methods in AstroPack.
%        tools.code.generate_doc - arguments
%           tools.code.getAllFun - Generate a list of all functions and methods
% tools.code.identifySubPackagesInFolder - Identify all packages hierarchy in a folder name
%             tools.code.isClass - Check if an m file is a class (containing classdef statement)
%         tools.code.listClasses - find and display all classes in the AstroPack toolbox.
%        tools.code.listPackages - find and display all packages and subpackaes in the AstroPack toolbox.
%               tools.code.openb - Open matlab editor and save a backup copy of previous file
%   tools.code.prep_maat_website - Prepare the Matlab Astronomy & AStrophysics Toolbox website
% tools.code.read_user_pass_file - Read user/password from file
%            tools.code.unitTest - Package Unit-Test
% tools.code.obsolete.allFunList - Functions and Classes list for the tools.code.obsolete package
% tools.code.obsolete.install_maat - Install
% tools.code.obsolete.prep_function_list - Prepare list of all functions in the Astro Toolbox
%         tools.deriv.allFunList - Functions and Classes list for the tools.deriv package
%    tools.deriv.numerical_deriv - Numerical derivative of vectors
%          tools.find.allFunList - Functions and Classes list for the tools.find package
%            tools.find.bin_sear - Binary search for a value in a sorted vector.
%           tools.find.bin_sear2 - --------------------------------------------------------------------------
%           tools.find.bin_sear3 - --------------------------------------------------------------------------
% tools.find.find_local_extremum - Use stirling interpolation to find local extremum in vector.
%    tools.find.find_local_zeros - -----------------------------------------------------------------------------
%           tools.find.find_peak - ------------------------------------------------------------------------------
%    tools.find.find_peak_center - --------------------------------------------------------------------------
%       tools.find.fun_binsearch - --------------------------------------------------------------------------
%        tools.find.groupCounter - Group a vector of counters into successive numbers.
%           tools.find.mfind_bin - Binary search on a sorted vector running simolutnously on multiple values.
%            tools.find.unitTest - Package Unit-Test
%           tools.gui.allFunList - Functions and Classes list for the tools.gui package
%           tools.gui.stopButton - Create a stop button
%       tools.install.allFunList - Functions and Classes list for the tools.install package
%     tools.install.downloadData - 
%         tools.install.unitTest - Package Unit-Test
%        tools.interp.allFunList - Functions and Classes list for the tools.interp package
%      tools.interp.bessel_icoef - Calculate the Bessel interpolation coefficiant.
%       tools.interp.interp1_nan - Interpolate over NaNs in 1-D vector.
%      tools.interp.interp1_sinc - 1-D sinc interpolation
% tools.interp.interp1evenlySpaced - A faster versio of interp1q for evenly spaced data (linear interpolation).
%    tools.interp.interp1lanczos - 1-D Lanczos interpolation
%       tools.interp.interp2fast - Faster version of interp2
%          tools.interp.interp3p - Stirling interpolation
%       tools.interp.interp_diff - Interpolation based on 4th order Stirling formula
%   tools.interp.interp_diff_ang - Stirling 4th order interpolation for angular values
% tools.interp.interp_diff_longlat - Bessel interpolation of equally space time series of lon/lat coordinates
%          tools.interp.unitTest - Package Unit-Test
%         tools.latex.allFunList - Functions and Classes list for the tools.latex package
%        tools.latex.latex_table - Create a latex table from a data given in a cell array.
%           tools.latex.unitTest - Package Unit-Test
%          tools.math.allFunList - Functions and Classes list for the tools.math package
%            tools.math.unitTest - Package Unit-Test
%      tools.math.fft.allFunList - Functions and Classes list for the tools.math.fft package
%        tools.math.fft.fft_freq - Return the frequencies corresponding to fftshift(fft(vec_of_size_N))
%   tools.math.fft.fft_symmetric - Make a 1-D fft a complex-conjugate symmetric
%        tools.math.fft.unitTest - Package Unit-Test
%   tools.math.filter.allFunList - Functions and Classes list for the tools.math.filter package
%   tools.math.filter.cornerize1 - Pad a templare an put the template center at the corner, or center.
%      tools.math.filter.filter1 - Apply a 1D filter to data and return statistics in std units.
%   tools.math.filter.filter1ues - One dimensional filtering for unevenly spaced data.
%      tools.math.fit.allFunList - Functions and Classes list for the tools.math.fit package
%      tools.math.fit.fmincon_my - ------------------------------------------------------------------------------
% tools.math.fit.fminsearch_chi2 - ------------------------------------------------------------------------------
%   tools.math.fit.fminsearch_my - ------------------------------------------------------------------------------
%      tools.math.fit.fminunc_my - fminunc.m version in which it is possible to pass additional parameters to the function
%    tools.math.fit.ransacLinear - Fit a linear model Y=a+bX using RANSAC
%  tools.math.fit.ransacLinear2d - RANSAC fitting of 2D data to a 2D linear function
% tools.math.fit.ransacLinearModel - Fit a general linear model using a simplified RANSAC-like scheme
%      tools.math.fun.allFunList - Functions and Classes list for the tools.math.fun package
%    tools.math.fun.chebyshevFun - Generate an anonymous function for Chebyshev polynomials (using
%          tools.math.fun.sincos - Insert a column/s or row/s to a specific position in a matrix.
%  tools.math.fun.mex.allFunList - Functions and Classes list for the tools.math.fun.mex package
%   tools.math.geometry.Contents - 
% tools.math.geometry.allFunList - Functions and Classes list for the tools.math.geometry package
% tools.math.geometry.boundingCircle - fit the smallest-radius bounding circle to set of X, Y points
% tools.math.geometry.cells_intersect_line - Find cells in 2D grid that intersets a line.
% tools.math.geometry.cross1_fast - Fast version of cross product of two 3-elements vectors
% tools.math.geometry.cross_fast - Fast cross product of two 3-elements matrices
%    tools.math.geometry.curvlen - Calculate the length of a curve numerically.
% tools.math.geometry.dist_box_edge - Distance of points froma rectangular box.
% tools.math.geometry.dist_p2line - Distance between point and a line.
% tools.math.geometry.plane_dist - Distance between points on a 2D plane.
% tools.math.geometry.plane_dist_thresh - Check if the distance between points on a plane is below some value.
%   tools.math.geometry.polysort - Sort the vertices of convex polygon by position angle.
%       tools.math.geometry.rotm - Return a numeric or symbolic 3-D rotation matrix about the X, Y or Z axis
% tools.math.geometry.traj_mindist - Time of minimum distance between two 2-D linear trajetories
% tools.math.geometry.tri_equidist_center - Poistion of circumscribed circle.
%   tools.math.geometry.unitTest - Package Unit-Test
% tools.math.integral.QuarticSolver - Quartic integral solver: [x1,x2,x3,x4]=QuarticSolver(a,b,c,d,e)
% tools.math.integral.QuarticSolverVec - Quartic integral solver (vectorized): [x1, x2, x3, x4]=QuarticSolverVec(a,b,c,d,e)
% tools.math.integral.allFunList - Functions and Classes list for the tools.math.integral package
%      tools.math.integral.int2d - Numerical integration of a 2-D matrix
% tools.math.integral.integral_percentile - Given a tabulate function find limits that contains percentile
% tools.math.integral.quad_mult2bound - Numerical integration using quad, where the upper bound is a vector
%    tools.math.integral.quad_my - Pass arguments to function in quad
% tools.math.integral.sp_powerlaw_int - --------------------------------------------------------------------------
% tools.math.integral.summatlevel - --------------------------------------------------------------------------
% tools.math.integral.test_QuarticSolver - generate random coefficients for the vectorized tests
%   tools.math.integral.trapzmat - Trapezoidal numerical integration on columns or rows of matrices.
%   tools.math.integral.unitTest - Package Unit-Test
%       tools.math.stat.Contents - 
%     tools.math.stat.allFunList - Functions and Classes list for the tools.math.stat package
%           tools.math.stat.bc_a - ------------------------------------------------------------------------------
%       tools.math.stat.bin2dFun - 2-D binning and apply functions to bins
%  tools.math.stat.bootstrap_std - --------------------------------------------------------------------------
%    tools.math.stat.cel_coo_rnd - ------------------------------------------------------------------------------
%      tools.math.stat.cell_stat - ----------------------------------------------------------------------------
%   tools.math.stat.centermass2d - ------------------------------------------------------------------------------
% tools.math.stat.confint_probdist - ------------------------------------------------------------------------------
%        tools.math.stat.corrsim - Correlation between two vectors and confidence region using bootstrap
%    tools.math.stat.corrsim_cov - Correlation matrix between N columns and bootstrap estimation of errors.
%         tools.math.stat.err_cl - Numerical estimate of percentiles.
% tools.math.stat.error2ensemble - --------------------------------------------------------------------------
%     tools.math.stat.fab_counts - -------------------------------------------------------------------------
%         tools.math.stat.hist2d - calculate the 2-D histogram of 2-D data set.
%        tools.math.stat.iqrFast - A fast iqr (inter quantile range) function (without interpolation)
%      tools.math.stat.jackknife - Given an estimator, calculate the Jacknife StD.
%       tools.math.stat.lognlogs - ---------------------------------------------------------------------------
% tools.math.stat.max_likelihood - Likelihood from observations and numerical probability distribution.
%          tools.math.stat.maxnd - ------------------------------------------------------------------------------
%     tools.math.stat.mean_error - Calculate the error on the mean using std/sqrt(N).
%         tools.math.stat.meannd - ------------------------------------------------------------------------------
%       tools.math.stat.mediannd - ------------------------------------------------------------------------------
%          tools.math.stat.minnd - ------------------------------------------------------------------------------
%       tools.math.stat.mode_bin - --------------------------------------------------------------------------
%   tools.math.stat.mode_density - Calculate the mode by estimating the density of points
%       tools.math.stat.mode_fit - Estimate the mode of an array by fitting a Gaussian to its histogram.
%       tools.math.stat.mode_vec - Mode and variance of a distribution
%      tools.math.stat.moment_2d - ------------------------------------------------------------------------------
%    tools.math.stat.mutual_info - Calculate the mutual information of two vectors (degree of independency)
%        tools.math.stat.nanmean - faster version of nanmean using the 'omitnan' option.
%      tools.math.stat.nanmedian - faster version of nanmedian using the 'omitnan' option.
%        tools.math.stat.nanrstd - Robust nanstd.
%         tools.math.stat.nanstd - faster version of nanstd using the 'omitnan' option.
%         tools.math.stat.noiser - --------------------------------------------------------------------------
%      tools.math.stat.poissconf - Upper/lower confidence intervals on N events assuming Poisson statistics
%  tools.math.stat.prob2find_inr - ------------------------------------------------------------------------------
%         tools.math.stat.psigma - --------------------------------------------------------------------------
%   tools.math.stat.quantileFast - A fast quantile function (without interpolation)
%    tools.math.stat.rand_circle - ------------------------------------------------------------------------------
%        tools.math.stat.rand_ps - Generate a random time series with a given power spectrum.
%     tools.math.stat.rand_range - --------------------------------------------------------------------------
%        tools.math.stat.randgen - Random numbers generator for arbitrary  distribution.
%  tools.math.stat.randinpolygon - Generate random positions inside a polygon
%        tools.math.stat.rangend - ------------------------------------------------------------------------------
%       tools.math.stat.realhist - Calculate histogram for a dataset in a given range.
%          tools.math.stat.rmean - Calculate the rubust mean over one of the dimensions.
%           tools.math.stat.rstd - Robust std calculated from the 50  inner percentile of the data.
%    tools.math.stat.sphere_conv - --------------------------------------------------------------------------
%    tools.math.stat.stat_in_htm - SHORT DESCRIPTION HERE
%          tools.math.stat.std_w - --------------------------------------------------------------------------
%          tools.math.stat.stdnd - Return the global StD of a N-D matrix.
%          tools.math.stat.sumnd - ------------------------------------------------------------------------------
%       tools.math.stat.unitTest - Package Unit-Test
%          tools.math.stat.wmean - --------------------------------------------------------------------------
%        tools.math.stat.wmedian - Weighted median for a vector.
%     tools.math.stat.wmedian_im - --------------------------------------------------------------------------
% tools.math.symbolic.allFunList - Functions and Classes list for the tools.math.symbolic package
% tools.math.symbolic.symbolic_poly - Build a symbolic polynomial
%   tools.math.symbolic.symerror - Calculate symbolic errors
% tools.math.symbolic.symerror_calc - Calculate and evaluate symbolic errors
% tools.math.symbolic.sympoly2d_2orders - Convert a 2D symbolic polynomials into vectors of orders and coef.
%   tools.math.symbolic.unitTest - Package Unit-Test
%     tools.operators.allFunList - Functions and Classes list for the tools.operators package
%          tools.operators.test1 - Rows = 1000;
%          tools.operators.times - 
%       tools.operators.unitTest - Package Unit-Test
% tools.operators.mex.allFunList - Functions and Classes list for the tools.operators.mex package
%            tools.os.allFunList - Functions and Classes list for the tools.os package
%                    tools.os.cd - Change dir function. If no arguments cd to home dir.
%               tools.os.cdmkdir - cd to directory - if not exist than create
%             tools.os.class_mlx - Open MLX file of class, which is expected in folder '/help/mlx/.../ClassName.mlx'
%  tools.os.copyJavaJarToTempDir - Copy Java .jar file to temporary folder and it to javaaddpath()
% tools.os.getAstroPackConfigPath - 
%  tools.os.getAstroPackDataPath - 
% tools.os.getAstroPackExternalPath - 
%      tools.os.getAstroPackPath - Return the AstroPack toolbox path
%            tools.os.getTempDir - 
%        tools.os.getTestDataDir - Return the path containing the test images used by the unitTest
%        tools.os.getTestWorkDir - 
%       tools.os.getUltrasatPath - 
%     tools.os.get_avx_supported - persistent avx;
%          tools.os.get_computer - Get computer name
%              tools.os.get_user - Get user name
%          tools.os.get_userhome - Get user home directory path
%               tools.os.islinux - 
%             tools.os.iswindows - 
%            tools.os.matlab_pid - Return the matlab PID and computer host name
%           tools.os.memoryLinux - Get the MATLAB memory and CPU usage (for Linux only).
%           tools.os.package_mlx - Open MLX file of class, which is expected in folder '/help/mlx/.../+Package.mlx'
%             tools.os.runPython - Run python with specified script
%           tools.os.system_list - Run the system command on a list of files.
%             tools.os.systemarg - Running the UNIX system command.
%              tools.os.unitTest - Package Unit-Test
%             tools.os.user_name - Get user name
%        tools.os.mex.allFunList - Functions and Classes list for the tools.os.mex package
%          tools.rand.allFunList - Functions and Classes list for the tools.rand package
%            tools.rand.randi100 - Generate random integers in range 0..100
%            tools.rand.unitTest - Package Unit-Test
%             tools.rand.utrandi - Generate random integers for unit-testing, range is 0..100
%        tools.string.allFunList - Functions and Classes list for the tools.string package
% tools.string.construct_fullpath - Construct a full path string to a program name, given its name
% tools.string.construct_keyval_string - --------------------------------------------------------------------------
%      tools.string.find_strcmpi - --------------------------------------------------------------------------
%           tools.string.islower - return true is char array is lower case
%         tools.string.read_date - ------------------------------------------------------------------------------
% tools.string.read_str_formatted - Read a string which is formatted by specidc column positions
%          tools.string.spacedel - recursively delete all spaces from a string.
%         tools.string.spacetrim - Recursively replace any occurance of two spaces with a single space.
%  tools.string.str2double_check - --------------------------------------------------------------------------
%       tools.string.str2num_nan - --------------------------------------------------------------------------
%     tools.string.str_duplicate - Duplicate a string multiple times.
%       tools.string.strcmp_cell - --------------------------------------------------------------------------
%  tools.string.strdouble2double - Convert string, double or any data type to double.
%   tools.string.stringSearchFun - Return a function handle for a string search (i.e., strcmp, strcmpi, regexp, regexpi
%     tools.string.strlines2cell - break the string into a cell array in which each cell contains a line.
%          tools.string.unitTest - Package Unit-Test
%           tools.string.unsplit - unsplit a cell array of strings.
%        tools.struct.allFunList - Functions and Classes list for the tools.struct package
%          tools.struct.copyProp - Copy properties between struct, with optional checking they exist.
%     tools.struct.isfield_check - If field exist run a function of fiel.
%  tools.struct.isfield_notempty - Check if field exist and not empty
%       tools.struct.mergeStruct - Merge two structures (unique fields)
%  tools.struct.mergeStructArray - Merge each field in a structure array into the same field in a single element structure.
% tools.struct.recursiveSearchField - Search recursively and return a field name in structure.
%     tools.struct.reshapeFields - Reshape all fields which have a consistent size
%       tools.struct.sort_struct - Sort all the elements in a structure by one fields in the structure.
%     tools.struct.string2fields - Construct a sub structure from string of several fields
%     tools.struct.struct2keyval - Convert a structure into a cell array of key,val,...
% tools.struct.struct2keyvalcell - Structure field name and content to cell array of key,val pairs
%       tools.struct.struct2text - Structure field name and content to text, with recursion
%   tools.struct.struct2varargin - Structure field name and content to cell array of key,val pairs
%   tools.struct.structEmpty2NaN - Replace empty fields in struct array with NaN
%        tools.struct.struct_def - Define a structure array of a specific size with fields.
%         tools.struct.structcon - Concatenate two structures into one.
%         tools.struct.structcut - Select elements in structure fields by indices.
%          tools.struct.unitTest - Package Unit-Test
% tools.struct.writeStructCsv_mex_test - 
%         tools.table.allFunList - Functions and Classes list for the tools.table package
%            tools.table.fprintf - fprintf for tables
%           tools.table.isColumn - Check if columns exist in table
 help tools.allFunList