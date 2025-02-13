% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/conversion.R
\name{rspec_to_pyspec}
\alias{rspec_to_pyspec}
\alias{spectraVariableMapping}
\alias{spectraVariableMapping,character-method}
\alias{pyspec_to_rspec}
\title{Low level functions to convert between Spectra and matchms Spectrum}
\usage{
spectraVariableMapping(pythonLibrary, ...)

\S4method{spectraVariableMapping}{character}(pythonLibrary = c("matchms", "spectrum_utils"), ...)

rspec_to_pyspec(
  x,
  pythonLibrary = c("matchms", "spectrum_utils"),
  BPPARAM = SerialParam(),
  .check = TRUE,
  ...
)

pyspec_to_rspec(
  x,
  BPPARAM = SerialParam(),
  .check = TRUE,
  pythonLibrary = c("matchms", "spectrum_utils"),
  ...
)
}
\arguments{
\item{pythonLibrary}{character(1)\verb{, the name of the target Python library, supported values are }"matchms"\code{and}"spectrum_utils"`}

\item{...}{additional arguments}

\item{x}{For \code{rspec_to_pyspec()}: \code{Spectra} object. For \code{pyspec_to_rspec()}:
a Python list of matchms Spectrum objects.}

\item{BPPARAM}{Optional parallel processing setup.}

\item{.check}{Optionally disable input parameter checking. Input parameter
checking should only disabled for very good reasons.}
}
\value{
For \code{rspec_to_pyspec()}: Python array of Spectrum objects, same
length than \code{x}. For \code{pyspec_to_rspec()}: \code{\link[Spectra:Spectra]{Spectra::Spectra()}} with the
converted spectra. For \code{spectraVariableMapping()}: named \code{character}
vector with names being \code{Spectra} variable names and values the
corresponding names in \code{matchms}.
}
\description{
The \code{rspec_to_pyspec()} and \code{pyspec_to_rspec()} functions allow to convert
R \code{\link[Spectra:Spectra]{Spectra::Spectra()}} objects into
\href{https://github.com/matchms/matchms}{matchms} Python \code{matchms.Spectrum}
objects. These functions are designed for
\strong{advanced users or developers} who want/need to integrate Python/matchms
functionality into R using \emph{reticulate}. All other users should use the
dedicated R functions within this package that take care of running the
Python code in the correct Python environment.

Parameter \code{mapping} allows to define which spectra variables (metadata)
should be copied between the R and Python spectra. Only provided spectra
variables will be copied to R respectively Python. \code{mapping} also defines
the mapping between the \code{Spectra}'s spectra variables and the Spectrum
metadata. The names of the character vector \code{mapping} are the R spectra
variables and the values the corresponding names in the Python's Spectrum
metadata. See the output of the \code{spectraVariableMapping()} function for the
default variables and the mapping of the names.

The \code{spectraVariableMapping()} function provides a default mapping of some
core \code{Spectra} variables based on this \href{https://github.com/matchms/matchms/blob/master/matchms/data/known_key_conversions.csv}{definition in matchms}.
The function returns a named vector that can be directly used as parameter
\code{mapping} in the \code{rspec_to_pyspec()} and \code{pyspec_to_rspec()} functions.
}
\examples{
## List the default spectra variables and their mapping.
spectraVariableMapping(pythonLibrary = "matchms")
spectraVariableMapping(pythonLibrary = "spectrum_utils")
library(Spectra)

DF <- DataFrame(
    msLevel = c(2L, 2L, 2L),
    name = c("Caffeine", "Caffeine", "1-Methylhistidine"),
    precursorMz = c(195.0877, 195.0877, 170.0924)
)
DF$intensity <- list(
    c(340.0, 416, 2580, 412),
    c(388.0, 3270, 85, 54, 10111),
    c(3.407, 47.494, 3.094, 100.0, 13.240))
DF$mz <- list(
    c(135.0432, 138.0632, 163.0375, 195.0880),
    c(110.0710, 138.0655, 138.1057, 138.1742, 195.0864),
    c(109.2, 124.2, 124.5, 170.16, 170.52))
sps <- Spectra(DF)

## apply the function rspec_to_pyspec on sps
rspec_to_pyspec(x = sps, pythonLibrary = "matchms")
## gives [Spectrum(precursor m/z=195.09, 4 fragments between 135.0 and 195.1), Spectrum(precursor m/z=195.09, 5 fragments between 110.1 and 195.1), Spectrum(precursor m/z=170.09, 5 fragments between 109.2 and 170.5)]

rspec_to_pyspec(x = sps, pythonLibrary = "spectrum_utils")
## gives [<spectrum_utils.spectrum.MsmsSpectrum>, <spectrum_utils.spectrum.MsmsSpectrum>, <spectrum_utils.spectrum.MsmsSpectrum>]

library(Spectra)

DF <- DataFrame(
    msLevel = c(2L, 2L, 2L),
    name = c("Caffeine", "Caffeine", "1-Methylhistidine"),
    precursorMz = c(195.0877, 195.0877, 170.0924)
)
DF$intensity <- list(
    c(340.0, 416, 2580, 412),
    c(388.0, 3270, 85, 54, 10111),
    c(3.407, 47.494, 3.094, 100.0, 13.240))
DF$mz <- list(
    c(135.0432, 138.0632, 163.0375, 195.0880),
    c(110.0710, 138.0655, 138.1057, 138.1742, 195.0864),
    c(109.2, 124.2, 124.5, 170.16, 170.52))
sps <- Spectra(DF)

## python library: matchms
## apply the function rspec_to_pyspec on sps
py_obj <- rspec_to_pyspec(x = sps, pythonLibrary = "matchms")
pyspec_to_rspec(py_obj, pythonLibrary = "matchms")

## python library: spectrum_utils
py_obj <- rspec_to_pyspec(x = sps, pythonLibrary = "spectrum_utils")
pyspec_to_rspec(py_obj, pythonLibrary = "spectrum_utils")

}
\author{
Michael Witting, Johannes Rainer, Thomas Naake
}
