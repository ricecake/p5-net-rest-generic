package Net::Rest::Generic::Utility;

use 5.006;
use strict;
use warnings FATAL => 'all';

use LWP;

sub _doRestCall {
        my ($method, $url, $args) = @_;
        #TODO: make the actual lwp call, and handle the things.
}

1;