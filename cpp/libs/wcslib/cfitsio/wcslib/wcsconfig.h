/* wcsconfig.h.  Generated from wcsconfig.h.in by configure.  */
/*============================================================================
*
* wcsconfig.h is generated from wcsconfig.h.in by 'configure'.  It contains
* C preprocessor macro definitions for compiling WCSLIB 7.3
*
* Author: Mark Calabretta, Australia Telescope National Facility, CSIRO.
* http://www.atnf.csiro.au/people/Mark.Calabretta
* $Id: wcsconfig.h.in,v 7.3.1.1 2020/06/03 03:38:11 mcalabre Exp mcalabre $
*===========================================================================*/

/* wcslib_version() is available (as of 5.0). */
#define HAVE_WCSLIB_VERSION

/* WCSLIB library version number. */
#define WCSLIB_VERSION 7.3.1

/* Define to 1 if sincos() is available. */
// @Chen #define HAVE_SINCOS 1

/* 64-bit integer data type. */
#define WCSLIB_INT64 long long int
