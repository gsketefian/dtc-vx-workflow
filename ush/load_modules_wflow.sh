#!/usr/bin/env bash

#
#-----------------------------------------------------------------------
#
# This script loads the workflow modulefile for a given machine.
# It is a central place for all other scripts so that this is the only
# place workflow module loading can be modified.
#
#-----------------------------------------------------------------------
#

function usage() {
  cat << EOF_USAGE
Usage: source $0 PLATFORM

OPTIONS:
   PLATFORM - name of machine you are on
      (e.g. derecho | hera | jet | orion | ursa | wcoss2 )
EOF_USAGE
}

echo
echo "================================================================"

# Make sure machine name is passed as first argument
if [ $# -eq 0 ]; then
  usage
  exit 1
fi

# help message
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  usage
  exit 0
fi

# Set machine name to lowercase
machine=${1,,}

# Get home directory
scrfunc_fp=$( readlink -f "${BASH_SOURCE[0]}" )
scrfunc_dir=$( dirname "${scrfunc_fp}" )
HOMEdir=$( dirname "${scrfunc_dir}" )

## source version file (run) only if it is specified in versions directory
#RUN_VER_FN="run.ver.${machine}"
#VERSION_FILE="${HOMEdir}/versions/${RUN_VER_FN}"
#if [ -f ${VERSION_FILE} ]; then
#  . ${VERSION_FILE}
#fi

# Source modulefile for this machine
WFLOW_MOD_FN="wflow_${machine}"
source "${HOMEdir}/etc/lmod-setup.sh" ${machine}
module use "${HOMEdir}/modulefiles"
#echo "AAAAAAA"
#echo "modulefiles directory is at:  ${HOMEdir}/modulefiles"
#set -x
#echo "BBBBBBB"
module load "${WFLOW_MOD_FN}"
#echo "CCCCCCC"
#alsdkfj
module load "${WFLOW_MOD_FN}" > /dev/null 2>&1 || { echo "ERROR:
Loading of platform-specific module file (WFLOW_MOD_FN) for the workflow 
task failed:
  WFLOW_MOD_FN = \"${WFLOW_MOD_FN}\""; exit 1; }

# Activate conda
#
# Set the has_mu flag to "true" if the shell options are such that unset
# variables will cause the script to crash (i.e. the nounset option is
# active).  Otherwise, set it to "false".
[[ ${SHELLOPTS} =~ nounset ]] && has_mu=true || has_mu=false
echo
echo "has_mu = |${has_mu}|"
#
# If the nounset option is enabled, disable it momentarily.
#$has_mu && set +u
#
location_of_conda=$(command -v conda)
echo
echo "location_of_conda = |${location_of_conda}|"

# Activate the conda environment for the vx workflow.
#if [ ! -z $(command -v conda) ]; then
#  conda activate vx_workflow
#fi
#
# If the nounset option was previously enabled, re-enable it if necessary.
#$has_mu && set -u

echo
echo "DING 1111"
output=$(which module)
echo "ouptut = |$output|"

# List loaded modulefiles
echo
echo "Modules BEFORE setup_conda.sh is called:"
echo
module --version
module list

#. $USHdir/../setup_conda.sh
source ${HOMEdir}/setup_conda.sh

echo
echo "DING 2222"
output=$(which module)
echo "ouptut = |$output|"

# List loaded modulefiles
echo
echo "Modules AFTER setup_conda.sh is called:"
echo
module --version
module list

