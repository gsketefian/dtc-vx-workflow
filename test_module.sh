#!/bin/bash -l

echo
echo "HI 01"

which module

echo
echo "HI 02"

alias

echo
echo "HI 03"

env

echo
echo "BYE"

exit 

#
#-----------------------------------------------------------------------
#
# Set shell options.
#
#-----------------------------------------------------------------------
#
set -u
#
#-----------------------------------------------------------------------
#
# Get the full path to the file in which this script/function is located
# (scrfunc_fp), the name of that file (scrfunc_fn), and the directory in
# which the file is located (scrfunc_dir).
#
#-----------------------------------------------------------------------
#
if [[ $(uname -s) == Darwin ]]; then
  command -v greadlink >/dev/null 2>&1 || { \
    echo >&2 "\
For Darwin-based operating systems (MacOS), the 'greadlink' utility is 
required to run the workflow. Reference the User's Guide for
more information about platform requirements. Aborting."; \
    exit 1; \
  }
  scrfunc_fp=$( greadlink -f "${BASH_SOURCE[0]}" )
else
  scrfunc_fp=$( readlink -f "${BASH_SOURCE[0]}" )
fi
scrfunc_fn=$( basename "${scrfunc_fp}" )
scrfunc_dir=$( dirname "${scrfunc_fp}" )
#
#-----------------------------------------------------------------------
#
# This script will be configured for a specific experiment when
# generate_vx_wflow.py. That process fills in what is necessary so
# this configured script in the experiment directory will need no
# additional information at run time.
#
#-----------------------------------------------------------------------
#
exptdir=$( dirname "$0" )
if [[ $(uname -s) == Darwin ]]; then
  command -v greadlink >/dev/null 2>&1 || { \
    echo >&2 "\
For Darwin-based operating systems (MacOS), the 'greadlink' utility is 
required to run the workflow. Reference the User's Guide for 
more information about platform requirements. Aborting."; 
    exit 1;
  }
  exptdir=$( greadlink -f "$exptdir" )
else
  exptdir=$( readlink -f "$exptdir" )
fi

