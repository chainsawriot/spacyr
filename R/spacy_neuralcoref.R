get_coref_model_url <- function(model = "en_coref_md") {
  sprintf("https://github.com/huggingface/neuralcoref-models/releases/download/%s-3.0.0/%s-3.0.0.tar.gz", model, model)
}

#' Install the neuralcoref model for a language model in a conda or virtual environment
#' 
#' Installs the [neuralcoref](https://github.com/huggingface/neuralcoref) (coreference resolution) model in a conda or virtualenv Python virtual
#' environment as installed by \code{\link{spacy_install}}.
#' @param envname name of the virtual environment
#' @param conda Path to conda executable.  Default \code{"auto"} which
#'   automatically finds the path.
#' @param model name of the language model to be installed. Currently only supports english, for which 
#'              three models exist from small to large: en_coref_sm (78mb), en_coref_md (161mb) and en_coref_lg (893mb). The medium
#'              size model (en_coref_md) is the recommended default.
#' @export
spacy_download_neuralcoref <- function(model = "en_coref_md",
                                     envname = "spacy_condaenv",
                                     conda = "auto") {
  message(sprintf("Installing model \"%s\"\n", model))
  model_url = get_coref_model_url(model)
  
  # resolve conda binary
  conda <- reticulate::conda_binary(conda)
  
  condaenv_bin <- function(bin) path.expand(file.path(dirname(conda), bin))
  cmd <- sprintf("%s%s %s && python -m pip install %s%s",
                 ifelse(is_windows(), "", ifelse(is_osx(), "source ", "/bin/bash -c \"source ")),
                 shQuote(path.expand(condaenv_bin("activate"))),
                 envname,
                 model_url,
                 ifelse(is_windows(), "", ifelse(is_osx(), "", "\"")))
  result <- system(cmd)
  
  # check for errors
  if (result != 0L) {
    stop("Error ", result, " occurred installing packages into conda environment ",
         envname, call. = FALSE)
  }
  message(sprintf("Language neuralcoref model \"%s\" is successfully installed\n", model))
  invisible(NULL)
}

