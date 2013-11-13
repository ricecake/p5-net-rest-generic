package Net::Rest::Generic::Utility;

use 5.006;
use strict;
use warnings FATAL => 'all';

use LWP::UserAgent;
use HTTP::Request::Common;

sub _doRestCall {
        my ($api, $method, $url, $args) = @_;
        $method = uc($method);
        $args ||= {};
        $api->{ua} ||= LWP::UserAgent->new;
        my ($request, @params) = _generateRequest($api, $method, $url, $args);
        $api->{ua}->request( $request, @params );
}

sub _generateRequest {
        my ($api, $method, $url, $args) = @_;

        my $ua = $api->{ua};
        my @parameters = ($url, %{$api->{_params}}, %{$args});
        my $parameterOffset;
        if ($method eq 'PUT'||$method eq 'POST') {
                $parameterOffset = ref($parameters[1])? 2 : 1;
        }
        else {
                $parameterOffset = 1;
        }

        my @stuff = $ua->_process_colonic_headers(\@parameters, 0);
        {
                no strict qw(refs);
                my $request = &{"HTTP::Request::Common::${method}"}( @parameters );
                $request->authorization_basic(
                        $api->{authorization_basic}{username},
                        $api->{authorization_basic}{password}
                ) if $api->{authorization_basic}{username};

                return ($request, @stuff);
        }

}

sub _validateInput {
        my $api = shift;
	my @modes = qw(delete get post put head);
	if (! grep (/$api->{mode}/i, @modes)) {
		return Net::Rest::Generic::Error->throw(
			category => 'input',
			message => 'mode must be one of the following: ' . join(', ', @modes) . '. You supplied: ' . $api->{mode},
		);
	}
	my @schemes = qw(http https);
	if (! grep (/$api->{scheme}/i, @schemes)) {
		return Net::Rest::Generic::Error->throw(
			category => 'input',
			message  => 'scheme must be one of the following: ' . join(', ', @schemes) . '. You supplied: ' . $api->{scheme},
		);
	}
        return 1;
}

1;
