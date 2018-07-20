# -*- coding: utf-8 -*-
#BEGIN_HEADER
#END_HEADER


class jgi_rqc_readqc:
    '''
    Module Name:
    jgi_rqc_readqc

    Module Description:
    A KBase module: jgi_rqc_readqc
    '''

    ######## WARNING FOR GEVENT USERS ####### noqa
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    ######################################### noqa
    VERSION = "0.0.1"
    GIT_URL = "https://github.com/sulsj/jgi_rqc_readqc.git"
    GIT_COMMIT_HASH = "1ceffb545849cdeb9dabf9c65dac80bf52ed3114"

    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass


    def run_readqc_app(self, ctx, params):
        """
        Run readqc and save a KBaseReport with the output.
        :param params: instance of type "readqcAppParams" (Input for running
           readqc as a Narrative application.) -> structure: parameter
           "workspaceName" of String, parameter "fastqFile" of type
           "fastqFileRef" (An X/Y/Z style reference to a workspace object
           containing a fastq, either a "KBaseFile.PairedEndLibrary",
           "KBaseFile.SingleEndLibrary", "KBaseAssembly.PairedEndLibrary",
           "KBaseAssembly.SingleEndLibrary"), parameter "libName" of String,
           parameter "isMultiplexed" of type "boolean" (A boolean - 0 for
           false, 1 for true. @range (0, 1))
        :returns: instance of type "readqcAppOutput" (Output of the
           run_readqc_app function.) -> structure: parameter "reportName" of
           String, parameter "reportRef" of String
        """
        # ctx is the context object
        # return variables are: output
        #BEGIN run_readqc_app
        #END run_readqc_app

        # At some point might do deeper type checking...
        if not isinstance(output, dict):
            raise ValueError('Method run_readqc_app return value ' +
                             'output is not type dict as required.')
        # return the results
        return [output]

    def run_readqc(self, ctx, params):
        """
        Run readqc and return a shock node containing the zipped readqc output.
        :param params: instance of type "readqcParams" (Input for running
           readqc fastqFile - fastq file upon which readqc will be run. -OR-
           fastaFile - local FASTA file upon which readqc will be run.
           libName: input fastq/fasta's library name isMultiplexed: set 1 if
           the input is a multiplexed fastq/fasta) -> structure: parameter
           "fastqFile" of type "fastqFileRef" (An X/Y/Z style reference to a
           workspace object containing a fastq, either a
           "KBaseFile.PairedEndLibrary", "KBaseFile.SingleEndLibrary",
           "KBaseAssembly.PairedEndLibrary",
           "KBaseAssembly.SingleEndLibrary"), parameter "fastaFile" of type
           "fastaFileType" (A local FASTA file. path - the path to the FASTA
           file. label - the label to use for the file in the readqc output.
           If missing, the file name will be used.) -> structure: parameter
           "path" of String, parameter "label" of String, parameter "libName"
           of String, parameter "isMultiplexed" of type "boolean" (A boolean
           - 0 for false, 1 for true. @range (0, 1))
        :returns: instance of type "readqcOutput" (Ouput of the run_readqc
           function. shockId - the id of the shock node where the zipped
           readqc output is stored. handle - the new handle for the shock
           node, if created. nodeFileName - the name of the file stored in
           Shock. size - the size of the file stored in shock. readqcPath -
           the directory containing the readqc output and the zipfile of the
           directory.) -> structure: parameter "shockId" of String, parameter
           "handle" of type "Handle" (A handle for a file stored in Shock.
           hid - the id of the handle in the Handle Service that references
           this shock node id - the id for the shock node url - the url of
           the shock server type - the type of the handle. This should always
           be shock. file_name - the name of the file remote_md5 - the md5
           digest of the file.) -> structure: parameter "hid" of String,
           parameter "fileName" of String, parameter "id" of String,
           parameter "url" of String, parameter "type" of String, parameter
           "remoteMd5" of String, parameter "nodeFileName" of String,
           parameter "size" of String, parameter "readqcPath" of String
        """
        # ctx is the context object
        # return variables are: output
        #BEGIN run_readqc
        #END run_readqc

        # At some point might do deeper type checking...
        if not isinstance(output, dict):
            raise ValueError('Method run_readqc return value ' +
                             'output is not type dict as required.')
        # return the results
        return [output]
    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK",
                     'message': "",
                     'version': self.VERSION,
                     'git_url': self.GIT_URL,
                     'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
