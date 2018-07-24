#!/bin/bash
export PATH=/kb/module/jgi-rqc-pipeline/tools:$PATH
export PYTHONPATH=/kb/module/jgi-rqc-pipeline/tools:/jgi-rqc-pipeline/lib:$PYTHONPATH
#export NERSC_HOST=denovo
export NERSC_HOST=docker
#cd /kb/module/jgi-rqc-pipeline && git pull && python /kb/module/jgi-rqc-pipeline/readqc/readqc.py "$@"
python /kb/module/jgi-rqc-pipeline/readqc/readqc.py "$@"