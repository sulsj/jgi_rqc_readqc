task readqc {
    command {
        /readqc.sh -f /input/CTZOX/12540.1.263352.GAAGGAA-GAAGGAA.fastq.gz -o /out/ctzox -r 0 -l CTZOX --skip-blast -m 0
    }
    
    output {
        String out = read_string(stdout())
    }
    
    runtime {
        docker: "sulsj/readqc-alpine-openjdk:latest"
        #cpu: "4"
        #memory: "10GB"        
        continueOnReturnCode: false
    }
}

workflow readqcwf {
    call readqc
}