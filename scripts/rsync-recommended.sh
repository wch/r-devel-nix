#!/usr/bin/env bash

set -e

cran_rsync='cran.r-project.org::CRAN'
version='4.4.0'
script_dir=$(dirname $(realpath "$0"))


rsync -rcIzv --timeout=60 --verbose --delete --include="*.tar.gz" \
    --exclude=Makefile.in --exclude=Makefile.win --exclude=Makefile --exclude=".svn" \
    --exclude="CVS*" --exclude=.cvsignore --exclude="*.tgz" \
    "${cran_rsync}"/src/contrib/${version}/Recommended/ "${script_dir}"/_recommended || \
    { echo "*** rsync failed to update Recommended files ***" && exit 1; }

