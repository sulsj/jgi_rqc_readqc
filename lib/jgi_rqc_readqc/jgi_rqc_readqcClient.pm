package jgi_rqc_readqc::jgi_rqc_readqcClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

jgi_rqc_readqc::jgi_rqc_readqcClient

=head1 DESCRIPTION


A KBase module: jgi_rqc_readqc


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => jgi_rqc_readqc::jgi_rqc_readqcClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my %arg_hash2 = @args;
	if (exists $arg_hash2{"token"}) {
	    $self->{token} = $arg_hash2{"token"};
	} elsif (exists $arg_hash2{"user_id"}) {
	    my $token = Bio::KBase::AuthToken->new(@args);
	    if (!$token->error_message) {
	        $self->{token} = $token->token;
	    }
	}
	
	if (exists $self->{token})
	{
	    $self->{client}->{token} = $self->{token};
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 run_readqc_app

  $output = $obj->run_readqc_app($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a jgi_rqc_readqc.readqcAppParams
$output is a jgi_rqc_readqc.readqcAppOutput
readqcAppParams is a reference to a hash where the following keys are defined:
	workspaceName has a value which is a string
	fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
	libName has a value which is a string
	isMultiplexed has a value which is a jgi_rqc_readqc.boolean
fastqFileRef is a string
boolean is an int
readqcAppOutput is a reference to a hash where the following keys are defined:
	reportName has a value which is a string
	reportRef has a value which is a string

</pre>

=end html

=begin text

$params is a jgi_rqc_readqc.readqcAppParams
$output is a jgi_rqc_readqc.readqcAppOutput
readqcAppParams is a reference to a hash where the following keys are defined:
	workspaceName has a value which is a string
	fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
	libName has a value which is a string
	isMultiplexed has a value which is a jgi_rqc_readqc.boolean
fastqFileRef is a string
boolean is an int
readqcAppOutput is a reference to a hash where the following keys are defined:
	reportName has a value which is a string
	reportRef has a value which is a string


=end text

=item Description

Run readqc and save a KBaseReport with the output.

=back

=cut

 sub run_readqc_app
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function run_readqc_app (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to run_readqc_app:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'run_readqc_app');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "jgi_rqc_readqc.run_readqc_app",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'run_readqc_app',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method run_readqc_app",
					    status_line => $self->{client}->status_line,
					    method_name => 'run_readqc_app',
				       );
    }
}
 


=head2 run_readqc

  $output = $obj->run_readqc($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a jgi_rqc_readqc.readqcParams
$output is a jgi_rqc_readqc.readqcOutput
readqcParams is a reference to a hash where the following keys are defined:
	fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
	fastaFile has a value which is a jgi_rqc_readqc.fastaFileType
	libName has a value which is a string
	isMultiplexed has a value which is a jgi_rqc_readqc.boolean
fastqFileRef is a string
fastaFileType is a reference to a hash where the following keys are defined:
	path has a value which is a string
	label has a value which is a string
boolean is an int
readqcOutput is a reference to a hash where the following keys are defined:
	shockId has a value which is a string
	handle has a value which is a jgi_rqc_readqc.Handle
	nodeFileName has a value which is a string
	size has a value which is a string
	readqcPath has a value which is a string
Handle is a reference to a hash where the following keys are defined:
	hid has a value which is a string
	fileName has a value which is a string
	id has a value which is a string
	url has a value which is a string
	type has a value which is a string
	remoteMd5 has a value which is a string

</pre>

=end html

=begin text

$params is a jgi_rqc_readqc.readqcParams
$output is a jgi_rqc_readqc.readqcOutput
readqcParams is a reference to a hash where the following keys are defined:
	fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
	fastaFile has a value which is a jgi_rqc_readqc.fastaFileType
	libName has a value which is a string
	isMultiplexed has a value which is a jgi_rqc_readqc.boolean
fastqFileRef is a string
fastaFileType is a reference to a hash where the following keys are defined:
	path has a value which is a string
	label has a value which is a string
boolean is an int
readqcOutput is a reference to a hash where the following keys are defined:
	shockId has a value which is a string
	handle has a value which is a jgi_rqc_readqc.Handle
	nodeFileName has a value which is a string
	size has a value which is a string
	readqcPath has a value which is a string
Handle is a reference to a hash where the following keys are defined:
	hid has a value which is a string
	fileName has a value which is a string
	id has a value which is a string
	url has a value which is a string
	type has a value which is a string
	remoteMd5 has a value which is a string


=end text

=item Description

Run readqc and return a shock node containing the zipped readqc output.

=back

=cut

 sub run_readqc
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function run_readqc (received $n, expecting 1)");
    }
    {
	my($params) = @args;

	my @_bad_arguments;
        (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 1 \"params\" (value was \"$params\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to run_readqc:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'run_readqc');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "jgi_rqc_readqc.run_readqc",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'run_readqc',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method run_readqc",
					    status_line => $self->{client}->status_line,
					    method_name => 'run_readqc',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "jgi_rqc_readqc.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "jgi_rqc_readqc.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'run_readqc',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method run_readqc",
            status_line => $self->{client}->status_line,
            method_name => 'run_readqc',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for jgi_rqc_readqc::jgi_rqc_readqcClient\n";
    }
    if ($sMajor == 0) {
        warn "jgi_rqc_readqc::jgi_rqc_readqcClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 boolean

=over 4



=item Description

A boolean - 0 for false, 1 for true.
@range (0, 1)


=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 fastqFileRef

=over 4



=item Description

An X/Y/Z style reference to a workspace object containing a fastq, either a
"KBaseFile.PairedEndLibrary",
"KBaseFile.SingleEndLibrary",
"KBaseAssembly.PairedEndLibrary",
"KBaseAssembly.SingleEndLibrary"


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 fastaFileType

=over 4



=item Description

A local FASTA file.
path - the path to the FASTA file.
label - the label to use for the file in the readqc output. If missing, the file name will
be used.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
path has a value which is a string
label has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
path has a value which is a string
label has a value which is a string


=end text

=back



=head2 Handle

=over 4



=item Description

A handle for a file stored in Shock.
hid - the id of the handle in the Handle Service that references this shock node
id - the id for the shock node
url - the url of the shock server
type - the type of the handle. This should always be shock.
file_name - the name of the file
remote_md5 - the md5 digest of the file.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
hid has a value which is a string
fileName has a value which is a string
id has a value which is a string
url has a value which is a string
type has a value which is a string
remoteMd5 has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
hid has a value which is a string
fileName has a value which is a string
id has a value which is a string
url has a value which is a string
type has a value which is a string
remoteMd5 has a value which is a string


=end text

=back



=head2 readqcAppParams

=over 4



=item Description

Input for running readqc as a Narrative application.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
workspaceName has a value which is a string
fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
libName has a value which is a string
isMultiplexed has a value which is a jgi_rqc_readqc.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
workspaceName has a value which is a string
fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
libName has a value which is a string
isMultiplexed has a value which is a jgi_rqc_readqc.boolean


=end text

=back



=head2 readqcAppOutput

=over 4



=item Description

Output of the run_readqc_app function.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
reportName has a value which is a string
reportRef has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
reportName has a value which is a string
reportRef has a value which is a string


=end text

=back



=head2 readqcParams

=over 4



=item Description

Input for running readqc
fastqFile - fastq file upon which readqc will be run.
-OR-
fastaFile - local FASTA file upon which readqc will be run.

libName: input fastq/fasta's library name
isMultiplexed: set 1 if the input is a multiplexed fastq/fasta


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
fastaFile has a value which is a jgi_rqc_readqc.fastaFileType
libName has a value which is a string
isMultiplexed has a value which is a jgi_rqc_readqc.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
fastqFile has a value which is a jgi_rqc_readqc.fastqFileRef
fastaFile has a value which is a jgi_rqc_readqc.fastaFileType
libName has a value which is a string
isMultiplexed has a value which is a jgi_rqc_readqc.boolean


=end text

=back



=head2 readqcOutput

=over 4



=item Description

Ouput of the run_readqc function.
shockId - the id of the shock node where the zipped readqc output is stored.
handle - the new handle for the shock node, if created.
nodeFileName - the name of the file stored in Shock.
size - the size of the file stored in shock.
readqcPath - the directory containing the readqc output and the zipfile of the directory.


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
shockId has a value which is a string
handle has a value which is a jgi_rqc_readqc.Handle
nodeFileName has a value which is a string
size has a value which is a string
readqcPath has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
shockId has a value which is a string
handle has a value which is a jgi_rqc_readqc.Handle
nodeFileName has a value which is a string
size has a value which is a string
readqcPath has a value which is a string


=end text

=back



=cut

package jgi_rqc_readqc::jgi_rqc_readqcClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
