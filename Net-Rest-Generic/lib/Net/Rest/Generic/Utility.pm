package Net::Rest::Generic::Utility;

use 5.006;
use strict;
use warnings FATAL => 'all';

use LWP::UserAgent;

sub _doRestCall {
        my ($api, $method, $url, $args) = @_;
        $api->{ua} ||= LWP::UserAgent->new;
        $args ||= {};
        return $api->{ua}->$method($url, %{$api->{_params}}, %{$args});
}

sub _validateInput {
        my $api = shift;
	my @modes = qw(delete get post put);
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
