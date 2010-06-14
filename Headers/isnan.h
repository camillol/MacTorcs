/*
 isnan definition for gcc on Mac OS X, taken from math.h.
 isnan is not available to C++ code (see <http://gcc.gnu.org/ml/gcc/2005-01/msg00577.html>),
 and including math.h has no effect because it's undefined in cmath. So we redefine it here
 instead.
 */

#define isnan(x)	\
(	sizeof (x) == sizeof(float )	?	__inline_isnanf((float)(x))	\
:	sizeof (x) == sizeof(double)	?	__inline_isnand((double)(x))	\
:	__inline_isnan ((long double)(x)))
