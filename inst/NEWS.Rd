\newcommand{\PR}{\Sexpr[results=rd]{tools:::Rd_expr_PR(#1)}}

\name{NEWS}
\title{lme4 News}
\encoding{UTF-8}
\section{CHANGES IN VERSION 1.1-8}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item \code{getME} gains a \code{"Tlist"} option
      (returns a vector of template matrices from which the blocks of 
      \code{Lambda} are generated)
      \item \code{hatvalues} method returns the diagonal of the hat
      matrix of LMMs
      \item \code{nlminbwrap} convenience function allows use of
      \code{nlminb} without going through the \code{optimx} package
      \item \code{as.data.frame.VarCorr.merMod} gains an \code{order}
      option that allows the results to be sorted with variances first
      and covariances last (default) or in lower-triangle order
      \item allow more flexibility in \code{scales} for
      \code{xyplot.thpr} method (John Maindonald)
      \item models with only random effects of the form \code{1|f} have
      better starting values for \code{lmer} optimization (Gabor Grothendieck)
    }
  }
  \subsection{USER-VISIBLE CHANGES}{
    \itemize{
      \item \code{deviance()} now returns the deviance, rather than half the
      negative log-likelihood, for GLMMs (there is no difference for
      LMMs)
      \item convergence warning and diagnostic test issues are now
      reported in \code{print} and \code{summary} methods
      \item \code{update} now (attempts to) re-evaluate the original fit
      in the environment of its formula (as is done with \code{drop1})
      \item \code{refit} of a nonlinear mixed model fit now throws an
      error, but this will hopefully change in future releases (related
      to bug fixes for Github #231)
      
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item \code{simulate} and \code{predict} now work more
      consistently with different-length data, differing
      factor levels, and \code{NA} values (Github #153, #197, #246, #275)
      \item \code{refit} now works correctly for \code{glmer}
      fits (Github #231)
      \item fixed bug in \code{family.merMod}; non-default links
      were not retrieved correctly (Alessandro Moscatelli)
      \item fixed \code{bootMer} bug for \code{type=="parametric"},
      \code{use.u=TRUE} (Mark Lai)
      \item gradient scaling for convergence checks now uses the Cholesky factor of the
      Hessian; while it is more correct, this will lead to some additional (probably
      false-positive) convergence warnings

    }
  }
}  
  
\section{CHANGES IN VERSION 1.1-7}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item the \code{nloptr} package is now imported;
      a wrapper function (\code{nloptwrap}) is provided so that
      \code{lmerControl(optimizer="nloptwrap")} is all that's necessary
      to use \code{nloptr} optimizers in the nonlinear optimization
      stage (the default algorithm is NLopt's implementation
      of BOBYQA: see \code{?nloptwrap} for examples)
      \item preliminary implementation of checks for scaling
      of model matrix columns (see \code{check.scaleX} in
      \code{?lmerControl})
      \item \code{beta} is now allowed as a synonym for \code{fixef}
      when specifying starting parameters (Github #194)
    }
  }
  \subsection{USER-VISIBLE CHANGES}{
    \itemize{
      \item the use of \code{deviance} to return the REML criterion
      is now deprecated; users should use \code{REMLcrit()} instead
      (Github #211)
    \item changed the default value of \code{check.nobs.vs.rankZ} to
    \code{"ignore"} (Github #214)
    }
  }
    \subsection{BUG FIXES}{
    \itemize{
      \item change gradient testing from absolute to relative
      \item fix \code{confint(.,method="boot")} to allow/work
      properly with \code{boot.type} values other than \code{"perc"}
      (reported by Alan Zaslavsky)
      \item allow \code{plot()} to work when data are specified in a different
      environment (reported by Dieter Menne)
      \item \code{predict} and \code{simulate} work for matrix-valued
      predictors (Github #201)
      \item other \code{simulate} bugs (Github #212)
      \item \code{predict} no longer warns spuriously when
      original response was a factor (Github #205)
      \item fix memory access issues (Github #200)
    }
  }
}
\section{CHANGES IN VERSION 1.1-6}{
  This version incorporates no changes in functionality, just
  modifications to testing and dependencies for CRAN/backward compatibility.
  \subsection{BUG FIXES}{
    \itemize{
      \item change \code{drop1} example to prevent use of old/incompatible
      \code{pbkrtest} versions, for 2.15.3 compatibility
      \item explicitly \code{require(mlmRev)} for tests to prevent cyclic
      dependency
      \item bump \code{RcppEigen} Imports: requirement from >0.3.1.2.3 to
      >=0.3.2.0; \code{Rcpp} dependency to >= 0.10.5
    }
  }
}
\section{CHANGES IN VERSION 1.1-5}{
  \subsection{BUG FIXES}{
    \itemize{
      \item improved NA handling in \code{simulate} and \code{refit}
      \item made internal handling of \code{weights}/\code{offset}
      arguments slightly more robust (Github #191)
      \item handle non-positive-definite estimated fixed effect
      variance-covariance matrices slightly more generally/robustly
      (fall back on RX approximation, with a warning,
      if finite-difference Hessian
      is non-PD; return \code{NA} matrix if RX approximation is
      also bad)
    } 
  }
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item Added output specifying when Gauss-Hermite quadrature
      was used to fit the model, and specifying number of GHQ points
      (Github #190)
    }
  }
}
\section{CHANGES IN VERSION 1.1-4}{
  \subsection{BUG FIXES}{
    \itemize{
      \item Models with prior weights returned an incorrect sigma and
      deviance (Github issue #155). The deviance bug was only a
      practical issue in model comparisons, not with inferences given a
      particular model. Both bugs are now fixed.
      \item Profiling failed in some cases for models with vector random
      effects (Github issue #172)
      \item Standard errors of fixed effects are now computed
      from the approximate Hessian by default (see the
      \code{use.hessian} argument in \code{vcov.merMod}); this
      gives better (correct) answers when the estimates of
      the random- and fixed-effect parameters are correlated
      (Github #47)
    }
  }
  \subsection{MAJOR USER-VISIBLE CHANGES}{
    \itemize{
      \item The default optimizer for \code{lmer} fits has been
      switched from "Nelder_Mead" to "bobyqa" because we have
      generally found the latter to be more reliable.  To switch
      back to the old behaviour,
      use \code{control=lmerControl(optimizer="Nelder_Mead")}.
      \item Better handling of rank-deficient/overparameterized
      fixed-effect model matrices; see \code{check.rankX} option
      to \code{[g]lmerControl}.  The default value is
      "message+drop.cols", which automatically drops redundant
      columns and issues a message (not a warning). (Github #144)
    }
  }
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item slight changes in convergence checking; tolerances can
      be specified where appropriate, and some default tolerances
      have changed (e.g., \code{check.conv.grad})
      \item improved warning messages about rank-deficiency in X and Z
      etc. (warnings now try to indicate whether the unidentifiability
      is in the fixed- or random-effects part of the model)
      \item \code{predict} and \code{simulate} now prefer
      \code{re.form} as the argument to specify which random effects
      to condition on, but allow \code{ReForm}, \code{REForm}, or
      \code{REform}, giving a message (not a warning) that they are
      deprecated (addresses Github #170)
      \item small fixes for printing consistency in models with no
      fixed effects
      \item we previously exported a \code{fortify} function identical
      to the one found in \code{ggplot2} in order to be able to define a
      \code{fortify.merMod} S3 method without inducing a dependency on
      \code{ggplot2}.  This has now been unexported to avoid masking
      \code{ggplot2}'s own \code{fortify} methods; if you want to
      add diagnostic information to the results of a model, use
      \code{fortify.merMod} explicitly.
      \item \code{simulate.formula} now checks for names associated
      with the \code{theta} and \code{beta} parameter vectors. If
      missing, it prints a message (not a warning); otherwise, it
      re-orders the parameter vectors to match the internal
      representation.
      \item preliminary implementation of a \code{check.scaleX} argument
      in \code{[g]lmerControl} that warns about scaling if some columns
      of the fixed-effect model matrix have large standard
      deviations (relative to 1, or to each other)
    }
  }
}
\section{CHANGES IN VERSION 1.1-3}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item The gradient and Hessian are now computed via finite
      differencing after the nonlinear fit is done, and the results
      are used for additional convergence tests. Control of the
      behaviour is available through the \code{check.conv.*} options
      in \code{[g]lmerControl}. Singular fits (fits with estimated
      variances of zero or correlations of +/- 1) can also be tested for,
      although the current default value of the \code{check.conv.singular}
      option is \code{"ignore"}; this may be changed to \code{"warning"}
      in the future. The results are stored in \code{@optinfo$derivs}.
      (Github issue #120; based on code by Rune Christensen.)
      \item The \code{simulate} method will now work to generate
      simulations "from scratch" by providing a model formula,
      a data frame holding the predictor variables, and a list
      containing the values of the model parameters:
      see \code{?simulate.merMod}. (Github issue #115)
      \item \code{VarCorr.merMod} objects now have an \code{as.data.frame}
      method, converting the list of matrices to a more
      convenient form for reporting and post-processing. (Github issue #129)
    }
  }
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item results of \code{fitted()}, \code{predict()},
      and \code{residuals()} now have
      names in all cases (previously results were unnamed, or
      named only when predicting from new data)
      \item the \code{anova} method now has a \code{refit} argument
      that controls whether objects of class \code{lmerMod} should be
      refitted with ML before producing the \code{anova} table.
      (Github issues #141, #165; contributed by Henrik Singmann.)
      \item the \code{print} method for \code{VarCorr} objects
      now has a \code{formatter} argument for finer control
      of standard deviation and variance formats
      \item the \code{optinfo} slot now stores slightly more
      information, including the number of function evaluations
      (\code{$feval}).
      \item \code{dotplot.ranef.mer} now adds titles to sub-plots by default,
      like \code{qqmath.ranef.mer}
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item \code{fitted} now respects \code{na.action} settings (Github
      issue #149)
      \item \code{confint(.,method="boot")} now works when there are
      \code{NA} values in the original data set (Github issue #158)
      \item previously, the code stored the results (parameter values,
      residuals, etc.) based on the \emph{last} set of parameters
      evaluated, rather than the optimal parameters.  These were
      not always the same, but were almost always very close,
      but some previous results will change slightly
      (Github issue #166)
    }
  }
}
\section{CHANGES IN VERSION 1.1-0}{
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item when using the default \code{method="profile"},
      \code{confint} now returns appropriate upper/lower bounds
      (-1/1 for correlations, 0/Inf for standard deviations)
      rather than \code{NA} when appropriate
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item in a previous development version, \code{ranef} returned
      incorrect conditional variances (github issue #148). this is 
      now fixed
    }
  }
}

\section{CHANGES IN VERSION 1.0-6 (2013-10-27)}{
  \subsection{BUG FIXES}{
    \itemize{
      \item prediction now works when new data have fewer factor
      levels than are present in the original data (Github issue #143,
      reported by Rune Haubo)
      \item the existence of a variable "new" in the global environment
  would mess \code{lme4} up: reported at http://stackoverflow.com/questions/19801070/error-message-glmer-using-r-what-must-be-a-character-string-or-a-function
    }
  }
}

\section{CHANGES IN VERSION 1.0-5 (2013-10-24)}{
  \subsection{USER-VISIBLE CHANGES}{
    \itemize{
      \item \code{confint.merMod} and \code{vcov.merMod} are
      now exported, for downstream package-author convenience
      \item the package now depends on Matrix >=1.1-0 and RcppEigen
      >=0.3.1.2.3
      \item new \code{rename.response} option for \code{refit} (see BUG
      FIXES section)
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item eliminated redundant messages about suppressed
      fixed-effect correlation matrices when p>20
      \item most inverse-link functions are now bounded where
      appropriate by \code{.Machine$double.eps}, allowing fitting
      of GLMMs with extreme parameter values
      \item \code{merMod} objects created with \code{refit} did not
      work with \code{update}: optional
      \code{rename.response} option added to \code{refit.merMod}, to allow
      this (but the default is still \code{FALSE}, for
      back-compatibility) (reported by A. Kuznetsova)
      \item fixed buglet preventing on-the-fly creation of index variables,
      e.g. \code{y~1+(1|rownames(data))} (reported by J. Dushoff)
      \item \code{predict} now works properly for \code{glmer} models
      with basis-creating terms (e.g. \code{poly}, \code{ns})
      \item step sizes determined from fixed effect coefficient standard
      errors after first state of \code{glmer} fitting are now bounded,
      allowing some additional models to be fitted
    }
  }
}
\section{CHANGES IN VERSION 1.0-4 (2013-09-08)}{
  \subsection{BUG FIXES}{
    \itemize{
      \item \code{refit()} now works, again, with lists of
      length 1, so that e.g. \code{refit(.,simulate(.))} works.
      (Reported by Gustaf Granath)
      \item \code{getME(.,"ST")} was returning a list
      containing the Cholesky factorizations that get repeated in
      Lambda. But this was inconsistent with what \code{ST} represents in
      \code{lme4.0}. This inconsistency has now been fixed and
      \code{getME(.,"ST")} is now consistent with the definition of the
      \code{ST} matrix in \code{lme4.0}. See
      \code{https://github.com/lme4/lme4/issues/111} for more
      detail. Thanks to Vince Dorie.
      \item Corrected order of unpacking of standard
      deviation/correlation components, which affected results
      from \code{confint(.,method="boot")}. (Reported by Reinhold
      Kliegl)
      \item fixed a copying bug that made \code{refitML()}
      modify the original model
    }
  }
}

\section{CHANGES IN VERSION 1.0-1 (2013-08-17)}{
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item \code{check.numobs.*} and \code{check.numlev.*} in
      \code{(g)lmerControl} have been changed (from recent development
      versions) to \code{check.nobs.*} and
      \code{check.nlev.*} respectively, and the default values of
      \code{check.nlev.gtreq.5} and \code{check.nobs.vs.rankZ}
      have been changed to \code{"ignore"} and \code{"warningSmall"}
      respectively
      \item in \code{(g)lmerControl}, arguments to the optimizer
      should be passed as a list called \code{optCtrl}, rather than
      specified as additional (ungrouped) arguments
      \item the \code{postVar} argument to \code{ranef} has been
      changed to the (more sensible) \code{condVar} ("posterior variance"
      was a misnomer, "conditional variance" -- short for "variance of the
      conditional mode" -- is preferred)
      \item the \code{REform} argument to \code{predict} has been changed
      to \code{ReForm} for consistency
      \item the \code{tnames} function, briefly exported, has been
      unexported
      \item \code{getME(.,"cnms")} added
      \item \code{print} method for \code{merMod} objects is now more
      terse, and different from \code{summary.merMod}
      \item the \code{objective} method for the \code{respMod}
      reference class now takes an optional \code{sigma.sq} parameter
      (defaulting to \code{NULL}) to allow calculation of the
      objective function with a residual variance different from
      the profiled value (Vince Dorie)
    }
  }
}
\section{CHANGES IN VERSION 1.0-0 (2013-08-01)}{
  \subsection{MAJOR USER-VISIBLE CHANGES}{
    \itemize{
      \item Because the internal computational machinery has changed,
      results from the newest version of \code{lme4} will not be numerically
      identical to those from previous versions.  For reasonably well-
      defined fits, they will be extremely close (within numerical
      tolerances of 1e-4 or so), but for unstable or poorly-defined fits
      the results may change, and very unstable fits may fail when they
      (apparently) succeeded with previous versions. Similarly, some fits
      may be slower with the new version, although on average the new
      version should be faster and more stable. More numerical
      tuning options are now available (see below); non-default settings
      may restore the speed and/or ability to fit a particular model without
      an error. If you notice significant or disturbing changes when fitting
      a model with the new version of \code{lme4}, \emph{please notify the maintainers}.
      \item \code{VarCorr} returns its results in the same format as before (as a
      list of variance-covariance matrices with \code{correlation} and \code{stddev}
      attributes, plus a \code{sc} attribute giving the residual standard
      deviation/scale parameter when appropriate), but prints them in a
      different (nicer) way.
      \item By default \code{residuals} gives deviance (rather than Pearson)
      residuals when applied to \code{glmer} fits (a side effect of matching \code{glm}
      behaviour more closely).
      \item As another side effect of matching \code{\link{glm}}
      behaviour, reported log-likelihoods from \code{\link{glmer}} models
      are no longer consistent with those from pre-1.0 \code{lme4},
      but \emph{are} consistent with \code{glm}; see \code{\link{glmer}}
      examples.
    }
  }
  \subsection{MINOR USER-VISIBLE CHANGES}{
    \itemize{
      \item More use is made of S3 rather than S4 classes and methods: one
      side effect is that the \code{nlme} and \code{lme4} packages are now much more
      compatible; methods such as \code{fixef} no longer conflict.
      \item The internal optimizer has changed. \code{[gn]lmer} now has an
      \code{optimizer} argument; \code{"Nelder_Mead"} is the default for \code{[n]lmer},
      while a combination of \code{"bobyqa"} (an alternative derivative-free
      method) and \code{"Nelder_Mead"} is the default for \code{glmer}. To use the
      \code{nlminb} optimizer as in the old version of \code{lme4}, you can use
      \code{optimizer="optimx"} with \code{control=list(method="nlminb")} (you will
      need the \code{optimx} package to be installed and loaded). See
      \code{\link{lmerControl}} for details.
      \item Families in GLMMs are no longer restricted to built-in/hard-
      coded families; any family described in \code{\link{family}}, or following that
      design, is usable (although there are some hard-coded families, which
      will be faster).
      \item \code{[gn]lmer} now produces objects of class \code{merMod} rather than
      class \code{mer} as before.
      \item the structure of the \code{Zt} (transposed random effect
      design matrix) as returned by \code{getME(.,"Zt")}, and the
      corresponding order of the random effects vector
      (\code{getME(.,"u")}) have changed. To retrieve \code{Zt}
      in the old format, use \code{do.call(Matrix::rBind,getME(.,"Ztlist"))}.
      \item the package checks input more thoroughly for
      non-identifiable or otherwise problematic cases: see
      \code{\link{lmerControl}} for fine control of the test behaviour.
    }
  }
  \subsection{NEW FEATURES}{
    \itemize{
      \item A general-purpose \code{\link{getME}} accessor method allows
      extraction of a wide variety of components of a mixed-model
      fit. \code{getME} also allows a vector of objects to be returned as
      a list of mixed-model components. This has been backported to
      be compatible with older versions of \code{lme4} that still produce \code{mer}
      objects rather than \code{merMod} objects. However, backporting is incomplete;
      some objects are only extractable in newer versions of \code{lme4}.
      \item Optimization information (convergence codes, warnings, etc.)
      is now stored in an \code{@optinfo} slot.
      \item \code{\link{bootMer}} provides a framework for obtaining parameter confidence
      intervals by parametric bootstrapping.
      \item \code{\link{plot.merMod}} provides diagnostic plotting
      methods similar to those from the \code{nlme} package
      (although missing \code{augPred}).
      \item A \code{\link{predict.merMod}} method gives predictions;
      it allows an effect-specific choice of conditional prediction or prediction at the
      population level (i.e., with random effects set to zero).
      \item Likelihood profiling for \code{lmer} and \code{glmer} results (see
      \code{link{profile-methods}}).
      \item Confidence intervals by likelihood profiling (default),
      parametric bootstrap, or Wald approximation (fixed effects only):
      see \code{\link{confint.merMod}}
      \item \code{nAGQ=0}, an option to do fast (but inaccurate) fitting of GLMMs.
      \item Using \code{devFunOnly=TRUE} allows the user to extract a deviance
      function for the model, allowing further diagnostics/customization of
      model results.
      \item The internal structure of [gn]lmer is now more modular, allowing
      finer control of the different steps of argument checking; construction
      of design matrices and data structures; parameter estimation; and construction
      of the final \code{merMod} object (see \code{?modular}).
      \item the \code{formula}, \code{model.frame}, and \code{terms}
      methods return full versions (including random effect terms and
      input variables) by default, but a \code{fixed.only} argument
      allows access to the fixed effect submodel.
    }
  }
  \subsection{EXPERIMENTAL FEATURES}{
    \itemize{
      \item \code{\link{glmer.nb}} provides an embryonic negative
      binomial fitting capability.
    }
  }
  \subsection{STILL NON-EXISTENT FEATURES}{
    \itemize{
      \item Adaptive Gaussian quadrature (AGQ) is not available for multiple and/or
      non-scalar random effects.
      \item Posterior variances of conditional models for non-scalar random effects.
      \item Standard errors for \code{\link{predict.merMod}} results.
      \item Automatic MCMC sampling based on the fit turns out to be very difficult
      to implement in a way that is really broadly reliable and robust; \code{mcmcsamp}
      will not be implemented in the near future. See
      \code{\link{pvalues}} for alternatives.
      \item "R-side" structures (within-block correlation and heteroscedasticity) are
      not on the current timetable.
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item In a development version, prior weights were not being used properly in
      the calculation of the residual standard deviation, but this has been fixed.
      Thanks to Simon Wood for pointing this out.
      \item In a development version, the step-halving component of the penalized
      iteratively reweighted least squares algorithm was not working, but
      this is now fixed.
      \item In a development version, square \code{RZX} matrices would lead to a
      \code{pwrssUpdate did not converge in 30 iterations} error. This has been fixed
      by adding an extra column of zeros to \code{RZX}.
    }
  }
  \subsection{DEPRECATED AND DEFUNCT}{
    \itemize{
      \item Previous versions of \code{lme4} provided
      the \code{mcmcsamp} function, which efficiently generated
      a Markov chain Monte Carlo sample from the posterior
      distribution of the parameters, assuming flat (scaled
      likelihood) priors. Due to difficulty in constructing a
      version of \code{mcmcsamp} that was reliable even in
      cases where the estimated random effect variances were
      near zero (e.g.
      \url{https://stat.ethz.ch/pipermail/r-sig-mixed-models/2009q4/003115.html}),
      \code{mcmcsamp} has been withdrawn (or more precisely,
      not updated to work with \code{lme4} versions >=1.0).
      \item Calling \code{glmer} with the default \code{gaussian} family
      redirects to \code{lmer}, but this is deprecated
      (in the future \code{glmer(...,family="gaussian")} may
      fit a LMM using the penalized iteratively reweighted least squares
      algorithm). Please call \code{lmer} directly.
      \item Calling \code{lmer} with a \code{family} argument redirects
      to \code{glmer}; this is deprecated. Please call \code{glmer} directly.
    }
  }
}
\section{CHANGES IN VERSION 0.999375-16 (2008-06-23)}{
  \subsection{MAJOR USER-VISIBLE CHANGES}{
    \itemize{
       \item The underlying algorithms and representations for all the
       mixed-effects models fit by this package have changed - for
       the better, we hope. The class "mer" is a common
       mixed-effects model representation for linear, generalized
       linear, nonlinear and generalized nonlinear mixed-effects
       models.
       \item ECME iterations are no longer used at all, nor are analytic
       gradients. Components named 'niterEM', 'EMverbose', or
       'gradient' can be included in the 'control' argument to
       lmer(), glmer() or nlmer() but have no effect.
       \item PQL iterations are no longer used in glmer() and nlmer().
       Only the Laplace approximation is currently available. AGQ,
       for certain classes of GLMMs or NLMMs, is being added.
       \item The 'method' argument to lmer(), glmer() or nlmer() is
       deprecated. Use the 'REML = FALSE' in lmer() to obtain ML
       estimates. Selection of AGQ in glmer() and nlmer() will be
       controlled by the argument 'nAGQ', when completed.
    }
  }
  \subsection{NEW FEATURES}{
    \itemize{
      \item The representation of mixed-effects models has been
      dramatically changed to allow for smooth evaluation of the
      objective as the variance-covariance matrices for the random
      effects approach singularity. Beta testers found this
      representation to be more robust and usually faster than
      previous versions of lme4.
      \item The mcmcsamp function uses a new sampling method for the
      variance-covariance parameters that allows recovery from
      singularity. The update is not based on a sample from the
      Wishart distribution. It uses a redundant parameter
      representation and a linear least squares update.
      \item CAUTION: Currently the results from mcmcsamp look peculiar and
      are probably incorrect. I hope it is just a matter of my
      omitting a scaling factor but I have seen patterns such as
      the parameter estimate for some variance-covariance parameters
      being the maximum value in the chain, which is highly
      unlikely.
      \item The 'verbose' argument to lmer(), glmer() and nlmer() can be
      used instead of 'control = list(msVerbose = TRUE)'.
    }
  }
}
