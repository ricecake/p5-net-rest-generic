package Net::Rest::Generic::Utility;

use 5.006;
use strict;
use warnings FATAL => 'all';

use LWP::UserAgent;

my $userAgent;

sub _doRestCall {
        my ($method, $url, $args) = @_;
        $userAgent ||= LWP::UserAgent->new;
        $args ||= {};
        return $userAgent->$method($url, %{$args});
}

1;