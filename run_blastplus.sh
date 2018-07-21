#!/bin/bash
export PATH=/jgi-rqc-pipeline/tools:$PATH
export PYTHONPATH=/jgi-rqc-pipeline/tools:/jgi-rqc-pipeline/lib:$PYTHONPATH
#export NERSC_HOST=denovo
export NERSC_HOST=docker
python /jgi-rqc-pipeline/tools/run_blastplus_taxserver.py "$@"