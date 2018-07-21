FROM kbase/kbase:sdkbase2.latest
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update
RUN apt-get install -y gawk libmysqlclient-dev

# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

#############################################
## bbtools
#############################################
#ENV BBTOOLS_VER 38.06
#RUN wget http://downloads.sourceforge.net/project/bbmap/BBMap_${BBTOOLS_VER}.tar.gz
#RUN tar -xzvf BBMap_${BBTOOLS_VER}.tar.gz
#RUN rm -rf /BBMap_${BBTOOLS_VER}.tar.gz
#RUN wget https://sourceforge.net/projects/bbmap/files/latest/download/bbmap.tar.gz \
#    && tar -xzvf bbmap.tar.gz \
#    && rm -rf bbmap.tar.gz

#############################################
# readqc
#############################################
#RUN git clone http://gitlab+deploy-token-3510:o1MENCTuP2HMY5Go_sUk@gitlab.com/sulsj/jgi-rqc-pipeline.git
#COPY run_blastplus.sh /kb/module
#COPY readqc.sh /kb/module

#############################################
# Python packages
#############################################
#RUN pip install --upgrade pip \
#    && pip install testresources colorlog mpld3 pysam cx_Oracle

#############################################
# R packages
#############################################
s#RUN apt-get install -y r-base
#RUN Rscript -e "install.packages(c('devtools', 'covr', 'roxygen2', 'testthat', 'stringr'), repos = 'https://cloud.r-project.org/')"
#RUN Rscript -e "install.packages('ggplot2', dependencies=TRUE, repos='http://cran.us.r-project.org')" && \
#    Rscript -e "install.packages('tidyr', dependencies=TRUE, repos='http://cran.us.r-project.org')" && \
#    Rscript -e "install.packages('docopt', dependencies=TRUE, repos='http://cran.us.r-project.org')" && \
#    Rscript -e "install.packages('dplyr', dependencies=TRUE, repos='http://cran.us.r-project.org')"
##RUN R -e "source('https://bioconductor.org/biocLite.R'); biocLite('GenomicRanges')" && \
#    #R -e "source('https://bioconductor.org/biocLite.R'); biocLite('Biostrings')" && \
#    #rm -rf /tmp/*

#RUN apt-get install -y --no-install-recommends \
#    libfftw3-dev \
#    gcc && apt-get clean \
#    && rm -rf /var/lib/apt/lists/*
#RUN Rscript -e 'source("http://bioconductor.org/biocLite.R")' -e 'biocLite("GenomicRanges")' \
#    && Rscript -e 'source("http://bioconductor.org/biocLite.R")' -e 'biocLite("Biostrings")'

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
#ENV CROMWELL_VER 33.1
#RUN CROMWELLJAR=cromwell-${CROMWELL_VER}.jar \
#    && wget -O $CROMWELLJAR https://github.com/broadinstitute/cromwell/releases/download/${CROMWELL_VER}/cromwell-${CROMWELL_VER}.jar
#COPY $CROMWELLJAR /kb/module/cromwell.jar
#COPY cromwell.sh /kb/module/
#COPY wdl/* /kb/module/


ENV PYTHONPATH="/kb/module/jgi-rqc-pipeline/lib:/kb/module/jgi-rqc-pipeline/tools:/usr/local/lib/python2.7/site-packages:${PYTHONPATH}"
ENV PATH=".:/kb/module/bbmap:/kb/module/jgi-rqc-pipeline/tools:/kb/module/jgi-rqc-pipeline/readqc/tools:/kb/module/jgi-rqc-pipeline/lib:${PATH}"
ENV NERSC_HOST="docker"

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
