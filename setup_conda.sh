# DO NOT RUN THIS SCRIPT AS A SHELL SCRIPT: IT MUST BE INVOKED USING THE source BUILTIN
(return 0 2>/dev/null) || {
    echo "ERROR: This script must be sourced, not executed." >&2
    exit 1
}
# Logic taken from UFS SRW Application (https://github.com/ufs-community/ufs-srweather-app)
VX_WFLOW_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
CONDA_BUILD_DIR="${VX_WFLOW_DIR}/conda"
os=$(uname)
if [ ! -d "${CONDA_BUILD_DIR}" ] ; then
  test $os == Darwin && os=MacOSX
  hardware=$(uname -m)
  installer=Miniforge3-${os}-${hardware}.sh
  curl -L -O "https://github.com/conda-forge/miniforge/releases/download/26.1.0-0/${installer}"
  bash ./${installer} -bfp "${CONDA_BUILD_DIR}"
  rm -f ${installer}
fi

echo
echo "HELLO 0000"

. ${CONDA_BUILD_DIR}/etc/profile.d/conda.sh
# Put some additional packages in the base environment on MacOS systems
if [ "${os}" == "MacOSX" ] ; then
  mamba install -y bash coreutils sed
fi

echo
echo "HELLO 1111"

conda activate
echo
echo "HELLO 2222"
if ! conda env list | grep -q "^vx_workflow\s" ; then
  mamba env create -n vx_workflow --file "${VX_WFLOW_DIR}/environment.yml" -y
fi

echo
echo "HELLO 3333"
if [[ ! "$PATH" =~ "$CONDA_BUILD_DIR" ]]; then
  export PATH=${CONDA_BUILD_DIR}/condabin:${CONDA_BUILD_DIR}/bin:${PATH}
fi
echo
echo "HELLO 4444"
# If LD_LIBRARY_PATH is undefined, set it to an empty string so it doesn't
# cause a crash if the nonset shell option is enabled.
${LD_LIBRARY_PATH:=}
if [[ ! "$LD_LIBRARY_PATH" =~ "$CONDA_BUILD_DIR" ]]; then
  export LD_LIBRARY_PATH=${CONDA_BUILD_DIR}/lib:${LD_LIBRARY_PATH}
fi

echo
echo "HELLO 5555"
output=$(which module)
echo "ouptut = |$output|"

conda activate vx_workflow

echo
echo "HELLO 6666"
output=$(which module)
echo "ouptut = |$output|"
