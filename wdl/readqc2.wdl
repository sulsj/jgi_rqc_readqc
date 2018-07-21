task readqc {
    command {
        #/readqc.sh -h
        #/readqc.sh -f /input/CTZOX/12540.1.263352.GAAGGAA-GAAGGAA.fastq.gz -o /out/ctzox -r 0 -l CTZOX --skip-blast -m 0
        #ls /input

        #docker run --rm -v /Users/sulsj/work/docker/readqc-alpine-openjdk/input:/input2 sulsj/readqc-alpine-openjdk ls /input2
        
        #docker run --rm -w $PWD -v /Users/sulsj/work/docker/readqc-alpine-openjdk/out:/out -v /Users/sulsj/work/docker/readqc-alpine-openjdk/data:/data:ro -v /Users/sulsj/work/docker/readqc-alpine-openjdk/input:/input:ro sulsj/readqc-alpine-openjdk ls /input/CTZOX

        docker run --rm -w $PWD -v /Users/sulsj/work/docker/readqc-alpine-openjdk/out:/out -v /Users/sulsj/work/docker/readqc-alpine-openjdk/data:/data:ro -v /Users/sulsj/work/docker/readqc-alpine-openjdk/input:/input:ro sulsj/readqc-alpine-openjdk /readqc.sh -f /input/CTZOX/12540.1.263352.GAAGGAA-GAAGGAA.fastq.gz -o /out/ctzox -r 0 -l CTZOX --skip-blast -m 0

    }
    
    output {
        String out = read_string(stdout())
    }
    
    # runtime {
    #     docker: "sulsj/readqc-alpine-openjdk"
    #     #volume_str: "/Users/sulsj/Work/docker/readqc-alpine-openjdk/input:/input"
    #     #cpu: "4"
    #     #memory: "10GB"
    #   }
}

workflow readqcwf {
    call readqc
}