/*
 isnan definition for gcc on Mac OS X, taken from math.h.
 isnan is not available to C++ code (see <http://gcc.gnu.org/ml/gcc/2005-01/msg00577.html>),
 and including math.h has no effect because it's undefined in cmath. So we redefine it here
 instead.
 */

#define isnan(x) std::isnan(x)
