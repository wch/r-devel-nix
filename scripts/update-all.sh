#!/usr/bin/env bash

script_dir=$(dirname "$0")

"${script_dir}"/rsync-recommended.sh
"${script_dir}"/gen-recommended-hash.sh
"${script_dir}"/get-r-source-commit-info.sh

