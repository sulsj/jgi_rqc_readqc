#!/bin/bash

# data directory is always mounted in the /data

check_exists() {
    if ! [ -d $1 ] ; then
        echo "Error initializing reference data; failed on: $1"
        fail=1
    fi
}

safe_execute() {
    cmd=$1
    echo "running $cmd"
    eval $cmd
    ret_code=$?
    if [ $ret_code != 0 ]; then
        echo $2
        exit $ret_code
    fi
}

fail=0

date

# Move to /data - that's got room for the big tar file.
mkdir -p /data
cd /data

## readqc ref + bbtools ref files
echo "Downloading reference database files..."
safe_execute "rm -rf jgi-rqc-readqc-ref" "Failed to remove reference data."
safe_execute "git clone http://gitlab+deploy-token-7962:e7obLrJbusxcaewmaFio@gitlab.com/sulsj/jgi-rqc-readqc-ref.git" "Failed to clone readqc ref data."
check_exists jgi-rqc-readqc-ref
safe_execute "tar -zxf jgi-rqc-readqc-ref/readqc_ref.tar.gz" "Failed to untar reference data."
safe_execute "rm -rf jgi-rqc-readqc-ref" "Failed to remove directory."

if [ $fail -eq 1 ] ; then
    echo "Unable to expand jgi-rqc-readqc-ref.tar.gz! Failing."
    exit 1
fi
echo "Done expanding readqc ref data"

date

if [ -f Illumina.artifacts.2013.12.no_DNA_RNA_spikeins.fa.gz ] && \
       [ -f fusedERPBBmasked.fa.gz ] && \
       [ -f adapters.fa ] && \
       [ -f Illumina.artifacts.2013.12.no_DNA_RNA_spikeins.fa ] && \
       [ -f DNA_spikeins.artifacts.2012.10.fa.bak ] && \
       [ -f RNA_spikeins.artifacts.2012.10.NoPolyA.fa ] && \
       [ -f JGIContaminants.fa ] && \
       [ -f pCC1Fos.ref.fa ] && \
       [ -f refseq.mitochondrion ] && \
       [ -f rRNA.fa ] && \
       [ -f refseq.plastid ] && \
       [ -f phix174_ill.ref.fa ] && \
       [ -f kapatags.L40.fa ] ; then
    echo "Success.  Writing __READY__ file."
    touch __READY__
else
    echo "Failed to download readqc ref data"
    exit 1
fi

exit 0