#############################################################
#
#	localdepth function
#	Author: Claudio Agostinelli and Mario Romanazzi
#	E-mail: claudio@unive.it
#	Date: September, 16, 2008
#	Version: 0.1-5
#
#	Copyright (C) 2008 Claudio Agostinelli and Mario Romanazzi
#
#############################################################

localdepth <- function(x, y=NULL, tau, use=c('volume', 'diameter'), method=c('simplicial', 'ellipsoid', 'mahalanobis'), type=c('exact', 'approx'), nsamp='all', nmax=1, tol=10^(-9), dimension=NULL) {
  use <- match.arg(use)
  method <- match.arg(method)
  type <- match.arg(type)

## simplicial
  if (method=='simplicial') {
    if (is.circular(x))
      localdepth.simp.circular(x=x, y=y, tau=tau, use=use)
    if (type=='exact' & ncol(x) < 3)
      localdepth.simp(x=x, y=y, tau=tau, use=use)
    else
      localdepth.simp.approx(x=x, y=y, tau=tau, use=use, nsamp=nsamp, nmax=1, tol=tol)
## mahalanobis    
  } else if (method=='mahalanobis') {
      if (is.circular(x)) stop("method 'mahalanobis' is not implemented for circular data")
      localdepth.mahalanobis(x=x, y=y, tau=tau)
## ellipsoid
  } else {
      if (is.circular(x)) stop("method 'ellipsoid' is not implemented for circular data")
      localdepth.ellipsoid(x=x, y=y, tau=tau, use=use, nsamp=nsamp, nmax=1, tol=tol, dimension=dimension)
  }
}
