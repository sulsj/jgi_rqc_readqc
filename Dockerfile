FROM kbase/kbase:sdkbase2.latest
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update
#RUN apt-get install -y gawk libmysqlclient-dev

# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

#############################################
# Install miniconda to /kb/module/miniconda
#############################################
#COPY environment.yml /kb/module/environment.yml
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
    && bash Miniconda-latest-Linux-x86_64.sh -p /kb/module/miniconda -b \
    && rm Miniconda-latest-Linux-x86_64.sh
RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
ENV PATH=/kb/module/miniconda/bin:${PATH}
RUN conda update -y conda

## Install r packages needed
RUN conda install -c r r-base \
    r-essentials r-caret r-devtools \
    r-roxygen2 r-testthat r-stringr \
    r-ggplot2 r-tidyr r-dplyr \
    && conda install -c conda-forge r-covr r-docopt r-purrr \
    && conda install -c bioconda bioconductor-genomicranges bioconductor-biostrings \
    && conda install gawk

#############################################
# Install Python packages needed
# This will be installed under /kb/module/miniconda/lib/python2.7/site-packages
#############################################
RUN pip install --upgrade pip \
    && pip install testresources colorlog mpld3 pysam cx_Oracle

#############################################
## bbtools
#############################################
RUN wget https://sourceforge.net/projects/bbmap/files/latest/download/bbmap.tar.gz \
    && tar -xzvf bbmap.tar.gz \
    && rm -rf bbmap.tar.gz

#############################################
# readqc
#############################################
RUN git clone http://gitlab+deploy-token-3510:o1MENCTuP2HMY5Go_sUk@gitlab.com/sulsj/jgi-rqc-pipeline.git
COPY run_blastplus.sh /kb/module
COPY readqc.sh /kb/module

#############################################
## blast+
#############################################
#ENV BLAST_VER 2.7.1
#RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${BLAST_VER}/ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz && \
#    tar xzf ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz
#ENV PATH="/kb/module/ncbi-blast-${BLAST_VER}+/bin:${PATH}"
#RUN rm -rf ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz

#############################################
## Cromwell
#############################################
ENV CROMWELL_VER 33.1
RUN CROMWELLJAR=cromwell-${CROMWELL_VER}.jar \
    && wget -O $CROMWELLJAR https://github.com/broadinstitute/cromwell/releases/download/${CROMWELL_VER}/cromwell-${CROMWELL_VER}.jar
COPY $CROMWELLJAR /kb/module/cromwell.jar
COPY cromwell.sh /kb/module/
COPY wdl/* /kb/module/


ENV PYTHONPATH="/kb/module/miniconda/lib/python2.7/site-packages:/kb/module/jgi-rqc-pipeline/lib:/kb/module/jgi-rqc-pipeline/tools:/usr/local/lib/python2.7/site-packages:${PYTHONPATH}"
ENV PATH=".:/kb/module/bbmap:/kb/module/jgi-rqc-pipeline/tools:/kb/module/jgi-rqc-pipeline/readqc/tools:/kb/module/jgi-rqc-pipeline/lib:${PATH}"
ENV NERSC_HOST="docker"

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
