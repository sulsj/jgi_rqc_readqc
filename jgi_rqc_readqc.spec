/*
A KBase module: jgi_rqc_readqc
*/

module jgi_rqc_readqc {

    /* A boolean - 0 for false, 1 for true.
        @range (0, 1)
    */
    typedef int boolean;

    /* An X/Y/Z style reference to a workspace object containing a fastq, either a
        "KBaseFile.PairedEndLibrary",
        "KBaseFile.SingleEndLibrary",
        "KBaseAssembly.PairedEndLibrary",
        "KBaseAssembly.SingleEndLibrary"
    */
    typedef string fastqFileRef;
    
    /* A local FASTA file.
        path - the path to the FASTA file.
        label - the label to use for the file in the readqc output. If missing, the file name will
        be used.
    */
    typedef structure {
        string path;
        string label;
    } fastaFileType;
    
    /* A handle for a file stored in Shock.
        hid - the id of the handle in the Handle Service that references this shock node
        id - the id for the shock node
        url - the url of the shock server
        type - the type of the handle. This should always be shock.
        file_name - the name of the file
        remote_md5 - the md5 digest of the file.
    */
    typedef structure {
        string hid;
        string fileName;
        string id;
        string url;
        string type;
        string remoteMd5;
    } Handle;
    
    
    
    
    /* Input for running readqc as a Narrative application.
    */
    typedef structure {
        string workspaceName;
        fastqFileRef fastqFile;
        string libName;
        boolean isMultiplexed;
    } readqcAppParams;
    
    /* Output of the run_readqc_app function. */
    typedef structure {
        string reportName;
        string reportRef;
    } readqcAppOutput;
    
    /* Run readqc and save a KBaseReport with the output. */
    funcdef run_readqc_app(readqcAppParams params) returns(readqcAppOutput output) authentication required;
    
    
    /* Input for running readqc
        fastqFile - fastq file upon which readqc will be run.
        -OR-
        fastaFile - local FASTA file upon which readqc will be run.

        libName: input fastq/fasta's library name
        isMultiplexed: set 1 if the input is a multiplexed fastq/fasta
        
    */
    typedef structure {
        fastqFileRef fastqFile;
        fastaFileType fastaFile;
        string libName;
        boolean isMultiplexed;
    } readqcParams;
    
    /* Ouput of the run_readqc function.
        shockId - the id of the shock node where the zipped readqc output is stored.
        handle - the new handle for the shock node, if created.
        nodeFileName - the name of the file stored in Shock.
        size - the size of the file stored in shock.
        readqcPath - the directory containing the readqc output and the zipfile of the directory.
    */
    typedef structure {
        string shockId;
        Handle handle;
        string nodeFileName;
        string size;
        string readqcPath;
    } readqcOutput;
    
    /* Run readqc and return a shock node containing the zipped readqc output. */
    funcdef run_readqc(readqcParams params) returns(readqcOutput output) authentication required;    
};