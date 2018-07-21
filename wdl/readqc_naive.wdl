task readqc {
    command {    
        docker run --rm -w $PWD \
        -v /Users/sulsj/work/docker/readqc-alpine-openjdk/out:/out \
        -v /Users/sulsj/work/docker/readqc-alpine-openjdk/data:/data:ro \
        -v /Users/sulsj/work/docker/readqc-alpine-openjdk/input:/input:ro \
        sulsj/readqc-alpine-openjdk /readqc.sh -f /input/CTZOX/12540.1.263352.GAAGGAA-GAAGGAA.fastq.gz -o /out/ctzox -r 0 -l CTZOX --skip-blast -m 0
    }
    output {
        String out = read_string(stdout())
    }
}

workflow readqcwf {
    call readqc
}