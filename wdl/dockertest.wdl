task dockerTest {
  command {
    taxon_filter.py --help
  }
  output {
    String out = read_string(stdout())
  }
  runtime {
    memory: "8GB"
    docker: "broadinstitute/viral-ngs"
  }
}

workflow dockerTestWf {
    call dockerTest
}