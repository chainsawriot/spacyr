% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spacy_neuralcoref.R
\name{spacy_download_neuralcoref}
\alias{spacy_download_neuralcoref}
\title{Install the neuralcoref model for a language model in a conda or virtual environment}
\usage{
spacy_download_neuralcoref(model = "en_coref_md",
  envname = "spacy_condaenv", conda = "auto")
}
\arguments{
\item{model}{name of the language model to be installed. Currently only supports english, for which 
three models exist from small to large: en_coref_sm (78mb), en_coref_md (161mb) and en_coref_lg (893mb). The medium
size model (en_coref_md) is the recommended default.}

\item{envname}{name of the virtual environment}

\item{conda}{Path to conda executable.  Default \code{"auto"} which
automatically finds the path.}
}
\description{
Installs the [neuralcoref](https://github.com/huggingface/neuralcoref) (coreference resolution) model in a conda or virtualenv Python virtual
environment as installed by \code{\link{spacy_install}}.
}
