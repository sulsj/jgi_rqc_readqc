# -*- coding: utf-8 -*-
import unittest
import os  # noqa: F401
import json  # noqa: F401
import time
import requests

from os import environ
try:
    from ConfigParser import ConfigParser  # py2
except:
    from configparser import ConfigParser  # py3

from pprint import pprint  # noqa: F401

from biokbase.workspace.client import Workspace as workspaceService
from jgi_rqc_readqc.jgi_rqc_readqcImpl import jgi_rqc_readqc
from jgi_rqc_readqc.jgi_rqc_readqcServer import MethodContext
from jgi_rqc_readqc.authclient import KBaseAuth as _KBaseAuth


class jgi_rqc_readqcTest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        token = environ.get('KB_AUTH_TOKEN', None)
        config_file = environ.get('KB_DEPLOYMENT_CONFIG', None)
        cls.cfg = {}
        config = ConfigParser()
        config.read(config_file)
        for nameval in config.items('jgi_rqc_readqc'):
            cls.cfg[nameval[0]] = nameval[1]
        # Getting username from Auth profile for token
        authServiceUrl = cls.cfg['auth-service-url']
        auth_client = _KBaseAuth(authServiceUrl)
        user_id = auth_client.get_user(token)
        # WARNING: don't call any logging methods on the context object,
        # it'll result in a NoneType error
        cls.ctx = MethodContext(None)
        cls.ctx.update({'token': token,
                        'user_id': user_id,
                        'provenance': [
                            {'service': 'jgi_rqc_readqc',
                             'method': 'please_never_use_it_in_production',
                             'method_params': []
                             }],
                        'authenticated': 1})
        cls.wsURL = cls.cfg['workspace-url']
        cls.wsClient = workspaceService(cls.wsURL)
        cls.serviceImpl = jgi_rqc_readqc(cls.cfg)
        cls.scratch = cls.cfg['scratch']
        cls.callback_url = os.environ['SDK_CALLBACK_URL']

    @classmethod
    def tearDownClass(cls):
        if hasattr(cls, 'wsName'):
            cls.wsClient.delete_workspace({'workspace': cls.wsName})
            print('Test workspace was deleted')

    def getWsClient(self):
        return self.__class__.wsClient

    def getWsName(self):
        if hasattr(self.__class__, 'wsName'):
            return self.__class__.wsName
        suffix = int(time.time() * 1000)
        wsName = "test_jgi_rqc_readqc_" + str(suffix)
        ret = self.getWsClient().create_workspace({'workspace': wsName})  # noqa
        self.__class__.wsName = wsName
        return wsName

    def getImpl(self):
        return self.__class__.serviceImpl

    def getContext(self):
        return self.__class__.ctx

    # NOTE: According to Python unittest naming rules test method names should start from 'test'. # noqa
    def test_your_method(self):
        # Prepare test objects in workspace if needed using
        # self.getWsClient().save_objects({'workspace': self.getWsName(),
        #                                  'objects': []})
        #
        # Run your method by
        # ret = self.getImpl().your_method(self.getContext(), parameters...)
        #
        # Check returned data with
        # self.assertEqual(ret[...], ...) or other unittest methods
        
        print "test..."
        
        import subprocess
        def runCommand(cmd):
            process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = process.communicate()
            exitcode = process.returncode
            return stdout.strip(), stderr.strip(), exitcode               
        
        cmd = "java -version; python -V"
        print runCommand(cmd)
        
        cmd = "echo $PATH; which reformat.sh; which Rscript; Rscript --version"
        print runCommand(cmd)
       
        ## Python dep check
        import cython
        import scipy
        import pika
        import colorlog
        import mpld3
        import yaml
        import Bio
        import pysam
        import jinja2
        import MySQLdb
        import cx_Oracle
        import matplotlib
        import shutil
        
        cmd = "which reformat.sh"
        print runCommand(cmd)
        
        
        ## upload
        ## https://gitlab.com/kbase-tools/kbase-binqc/blob/master/test/binqc_server_test.py
        # assembly_filename = 'allbins.fa'
        # cls.assembly_filename_path = os.path.join(cls.scratch, assembly_filename)
        # shutil.copy(os.path.join("data", assembly_filename), cls.assembly_filename_path)
        # # from scratch upload to workspace
        # assembly_params = {
        #     'file': {'path': cls.assembly_filename_path},
        #     'workspace_name': cls.ws_info[1],
        #     'assembly_name': 'MyAssembly'
        # }
        # cls.assembly_ref = cls.au.save_assembly_from_fasta(assembly_params)
       
        
        # ref = "79/16/1"        
        # ref = "16243/8/1" # 12544.1.263494.CGAGTAT-CGAGTAT.fastq.gz
        ref = "16243/6/1" # 7257.1.64419.CACATTGTGAG.fastq
        
        result = self.getImpl().run_readqc(self.getContext(), {
            'workspaceName': self.getWsName(),
            'fastqFile': ref,
            # 'libName': "CTZOX",
            # 'libName': "CUUOZ",
            'libName': "M1868.A9",              
            'isMultiplexed': 0
        })
        print result

