workflow myWorkflow {    
    call myTask 
    call copy {input: files=myTask.files}
}

task myTask {
    command {
        echo "hello world" > hello.txt && wc -l hello.txt > wc.out        
    }
    output {
        #String out = read_string(stdout())
        File helloOut = "hello.txt"
        File wcOut = "wc.out"
        Array[File] files = glob("*.out")                
    }
}

task copy {
    Array[File] files
    String dest = "/Users/sulsj/work/cromwell/wc-test/wc-copy-out"
    
    command {
        mkdir -p ${dest}
        cp -L -R -u ${sep=' ' files} ${dest}
    }
    output {
        Array[File] out = glob("${dest}/*.out")  
    }
}

