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

1;