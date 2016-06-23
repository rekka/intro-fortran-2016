#!/bin/sh

make
rsync -rlvc --delete --exclude='.DS_Store' public_html/ npozar@polaris.s.kanazawa-u.ac.jp:~/public_html/class/intro-fortran-2016/
