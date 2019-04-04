# [![spacyr: an R wrapper for spaCy](https://cdn.rawgit.com/quanteda/spacyr/master/images/spacyr_logo_small.svg)](https://spacyr.quanteda.io)

[![CRAN
Version](https://www.r-pkg.org/badges/version/spacyr)](https://CRAN.R-project.org/package=spacyr)
[![Travis-CI Build
Status](https://travis-ci.org/quanteda/spacyr.svg?branch=master)](https://travis-ci.org/quanteda/spacyr)
[![Appveyor Build
status](https://ci.appveyor.com/api/projects/status/jqt2atp1wqtxy5xd/branch/master?svg=true)](https://ci.appveyor.com/project/kbenoit/spacyr/branch/master)
[![codecov.io](https://codecov.io/github/quanteda/spacyr/coverage.svg?branch=master)](https://codecov.io/gh/quanteda/spacyr/branch/master)
[![Downloads](https://cranlogs.r-pkg.org/badges/spacyr)](https://CRAN.R-project.org/package=spacyr)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/spacyr?color=orange)](https://CRAN.R-project.org/package=spacyr)

An R wrapper to the spaCy “industrial strength natural language
processing”" Python library from <https://spacy.io>.

## Note about this fork

This fork of spacyr supports the use of coreference resolutions using the neuralcoref models. 
The models can be downloaded with the **spacy_download_neuralcoref()** function.
If a neuralcoref model is initialized, coreference resolution can be used with the coref=T argument in spacy_parse.

HOWEVER, there are some hoops to jump. neuralcoref currently does not work with spacy version >= 2.1.0. 
Using version 2.0.12 works, but if it is downgraded, there might in turn be some numpy related issues. 
A clean install of miniconda and spacyr works for me:

``` r
spacy_install(version = '2.0.12')

spacy_download_neuralcoref('en_coref_md')
spacy_initialize('en_coref_md')

spacy_parse('Steve and Anna said that they will be there. She convinced him',
            dependency=T, coref=T)
```

Note that I mainly developed this for own use, and have only tested on Linux. Once the version issues are solved
it might be good to see whether it is worthwhile to make a pullrequest. 

## Installing the package

1.  Install miniconda
    
    The easiest way to install spaCy and **spacyr** is through the
    **spacyr** function `spacy_install()`. This function by default
    creates a new conda environment called `spacy_condaenv`, as long as
    some version of conda is installed on the user’s the system. You can
    install miniconda from <https://conda.io/miniconda.html>. (Choose
    the 64-bit version, or alternatively, run to the computer store now
    and purchase a 64-bit system to replace your ancient 32-bit
    platform.)
    
    If you already have any version of conda, you can skip this step.
    You can check it by entering `conda --version` in the Terminal.
    
    For a Windows-based system, Visual C++ Build Tools or Visual Studio
    Express must be installed to compile spaCy for pip installation. The
    version of Visual Studio required for the installation of spaCy is
    found [here](https://spacy.io/usage/#source-windows) and the default
    python version used in our installation method is 3.6.x.

2.  Install the **spacyr** R package:
    
      - From GitHub:
        
        To install the latest package from source, you can simply run
        the following.
    
    <!-- end list -->
    
    ``` r
    devtools::install_github("quanteda/spacyr", build_vignettes = FALSE)
    ```
    
      - From CRAN:
    
    <!-- end list -->
    
    ``` r
    install.packages("spacyr")
    ```

3.  Install spaCy in a conda environment
    
      - For Windows, you need to run R as an administrator to make
        installation work properly. To do so, right click the RStudio
        icon (or R desktop icon) and select “Run as administrator” when
        launching R.
    
      - To install spaCy, you can simply run
    
    <!-- end list -->
    
    ``` r
    library("spacyr")
    spacy_install()
    ```
    
    This will create a stand-alone conda environment including a python
    executable separate from your system Python (or anaconda python),
    install the latest version of spaCy (and its required packages), and
    download English language model. After installation, you can
    initialize spaCy in R with
    
    ``` r
    spacy_initialize()
    ```
    
    This will return the following message if spaCy was installed with
    this method.
    
    ``` r
    ## Found 'spacy_condaenv'. spacyr will use this environment
    ## successfully initialized (spaCy Version: 2.0.18, language model: en)
    ## (python options: type = "condaenv", value = "spacy_condaenv")
    ```

4.  (optional) Add more language models
    
    For spaCy installed by `spacy_install()`, **spacyr** provides a
    useful helper function to install additional language models. For
    instance, to install German language model
    
    ``` r
    spacy_download_langmodel("de")
    ```
    
    (Again, Windows users have to run this command as an administrator.
    Otherwise, he symlink (alias) to the language model will fail.)

### Permanently setting the default Python

If you are using the same setting for spaCy (e.g. condaenv or python
path) every time and want to reduce the time for initialization, you can
fixate the setting by specifying it in an R-startup file (For Mac/Linux,
the file is `~/.Rprofile`), which is read every time a new `R` is
launched. You can set the option permanently when you call
`spacy_initialize()`:

``` r
spacy_initialize(save_profile = TRUE)
```

Once this is appropriately set up, the message from `spacy_initialize()`
changes to something like:

    ## spacy python option is already set, spacyr will use:
    ##  condaenv = "spacy_condaenv"
    ## successfully initialized (spaCy Version: 2.0.18, language model: en)
    ## (python options: type = "condaenv", value = "spacy_condaenv")

To ignore the permanently set options, you can initialize spacy with
`refresh_settings = TRUE`.

## Comments and feedback

We welcome your comments and feedback. Please file issues on the
[issues](https://github.com/quanteda/spacyr/issues) page, and/or send us
comments at <kbenoit@lse.ac.uk> and <A.Matsuo@lse.ac.uk>.
