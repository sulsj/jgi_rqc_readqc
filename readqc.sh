#!/bin/bash
export PATH=/jgi-rqc-pipeline/tools:$PATH
export PYTHONPATH=/jgi-rqc-pipeline/tools:/jgi-rqc-pipeline/lib:$PYTHONPATH
#export NERSC_HOST=denovo
export NERSC_HOST=docker
cd /jgi-rqc-pipeline && git pull && python /jgi-rqc-pipeline/readqc/readqc.py "$@"