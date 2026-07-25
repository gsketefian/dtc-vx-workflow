#!/bin/bash

#shopt -s expand_aliases
#alias grep_with_excludes="grep -n -r -I --exclude-dir=\*{aaa,conda,doc,tests,bbb}\* --exclude=\*{aaa,old,new,stuff,orig,bbb}\*"

grep_with_excludes() {
    grep -n -r -i -I --exclude-dir=\*{aaa,conda,doc,tests,bbb}\* --exclude=\*{aaa,old,new,orig,bbb}\* "$@"
}

expt_dir="/scratch4/BMC/fv3lam/Gerard.Ketefian/DTC_RRFSbench/expt_dirs/AIWP.HRRCast.works04.vxdet_and_vxens.nens_03.2026040100.with_WARNINGS"
log_file_base="grep_output"

i=0
log_fn=${log_file_base}.log.$(printf "%02d" $i).all_WARNINGs
echo
echo "log_fn = |${log_fn}|"
grep_with_excludes "WARNING" ${expt_dir}/log/* > ${log_fn}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="export_OFFSET_WARNING"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="export METPLUS_TIME_OFFSET_WARNING"
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="DEBUG_OFFSET_WARNING"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="DEBUG: METPLUS_TIME_OFFSET_WARNING="
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="WARNING_valid_time_changed"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="WARNING: get_data_plane() -> The valid time has changed,"
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="WARNING_valid_times_do_not_match"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="WARNING: process_scores() -> Forecast and observation valid times do not match"
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="ends_with_WARNING_colon"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="WARNING:[[:space:]]*$"
grep_with_excludes -v -E "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes -E "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="WARNING_OMP_NUM_THREADS"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="WARNING: Config variable OMP_NUM_THREADS"
grep_with_excludes -v -E "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes -E "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

log_fn_prev=${log_fn}
i=$((i+1))
desc_suffix="WARNING_could_not_find_FCST_INPUT_file"
log_bn="${log_file_base}.log.$(printf "%02d" $i)"
log_fn="${log_bn}.remove-${desc_suffix}"
echo
echo "log_fn = |${log_fn}|"
search_str="WARNING: Could not find FCST_INPUT file"
grep_with_excludes -v "${search_str}" ${log_fn_prev} > ${log_fn}
grep_with_excludes "${search_str}" ${log_fn_prev} > ${log_bn}.only-${desc_suffix}

exit



