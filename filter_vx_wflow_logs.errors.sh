#!/bin/bash

grep_with_excludes() {
    grep -r -i -I --exclude-dir=\*{aaa,conda,doc,tests,bbb}\* --exclude=\*{aaa,old,new,orig,bbb}\* "$@"
}

# /scratch4/BMC/fv3lam/Gerard.Ketefian/DTC_RRFSbench/expt_dirs/AIWP.HRRCast.works04.vxdet_and_vxens.nens_03.2026040100.with_WARNINGS"
expt_dir="$1"
log_file_base="grep_output"
rm -f ${log_file_base}*ERROR*

i=0
log_fn=${log_file_base}.log.$(printf "%02d" $i).all_ERRORs
echo
echo "log_fn = |${log_fn}|"
grep_with_excludes -n "ERROR" ${expt_dir}/log/* > ${log_fn}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="export_METPLUS_OBS_ERROR_FLAG"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.after_removing-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="export METPLUS_OBS_ERROR_FLAG="
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.contains_only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="DEBUG_MET_OBS_ERROR_TABLE"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.after_removing-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="DEBUG: MET_OBS_ERROR_TABLE="
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.contains_only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="DEBUG_METPLUS_OBS_ERROR_FLAG"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.after_removing-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="DEBUG: METPLUS_OBS_ERROR_FLAG="
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.contains_only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="DEBUG1_Reading_MET_OBS_ERROR_TABLE_file"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.after_removing-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="DEBUG 1: Reading user-defined MET_OBS_ERROR_TABLE file:"
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.contains_only-${desc_suffix}

echo
echo "Ouptut files containing remaining ERROR lines are:"
echo "(Last file should have 0 size if all ERROR lines have been removed.)"
\ls -alF ${log_file_base}*all*ERROR* ${log_file_base}*after_removing*ERROR*

echo
echo "Ouptut files containing only certain groups of ERROR lines are:"
\ls -alF ${log_file_base}*all*ERROR* ${log_file_base}*contains_only*ERROR*

