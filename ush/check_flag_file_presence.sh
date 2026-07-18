#!/bin/bash
#
# Checks whether at least num_obs_days workflow flag files matching
# flag_file_pattern, with an embedded date in [first_obs_day, last_obs_day],
# exist in wflow_flag_files_dir.  Exits with 0 if the check passes, 1
# otherwise.
#
# Usage:
#   check_flag_file_presence.sh <wflow_flag_files_dir> <flag_file_pattern> \
#     <first_obs_day> <last_obs_day> <num_obs_days>
#
# Example:
#   check_flag_file_presence.sh "/path/to/wflow_flag_files" \
#     "get_obs_ccpa_*_complete.txt" 20260201 20260205 5
#
wflow_flag_files_dir=$1
flag_file_pattern=$2
first_obs_day=$3
last_obs_day=$4
num_obs_days=$5
#
# The pipeline below works as follows:
#
# - find:
#   Locate flag files matching flag_file_pattern under wflow_flag_files_dir,
#   and print just their basenames (stderr suppressed so e.g. a missing
#   directory doesn't print noise).
#
# - grep:
#   Pull the 8-digit YYYYMMDD date out of each basename.
#
# - awk:
#   Keep only the dates that fall within [first_obs_day, last_obs_day]
#   (plain string comparison, which works since all dates are same-length
#   numeric strings).
#
# - test:
#   Count how many dates survived and compare against num_obs_days.  Note
#   that "$(wc -l)" is a command substitution that runs in a subshell
#   inheriting this pipeline's stdin, so it's actually "wc -l", not "test",
#   that reads the piped output; "test" then just compares the resulting
#   count.  The exit status of "test" (the pipeline's last stage) becomes
#   this script's exit status.
#
find ${wflow_flag_files_dir} -name "${flag_file_pattern}" -exec basename {} \; 2>/dev/null \
  | grep -oE '[0-9]{8}' \
  | awk -F/ -v s=${first_obs_day} -v e=${last_obs_day} '($NF >= s && $NF <= e)' \
  | test $(wc -l) -ge ${num_obs_days}
