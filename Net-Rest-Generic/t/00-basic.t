#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
plan tests => 8;

use_ok( 'Net::Rest::Generic' ) || print "Bail out!\n";

diag( "Testing Net::Rest::Generic $Net::Rest::Generic::VERSION, Perl $], $^X" );

sub defaults {
	my $api = Net::Rest::Generic->new();
	is($api->{mode}, 'get', 'GET is default mode');
	is($api->{scheme}, 'http', 'HTTP is default scheme');
}

sub basics {
	my %arguments = (
		mode   => 'post',
		scheme => 'https',
		host   => 'perl.org',
		port   => '8080',
		base   => 'version1'
	);

	my $api = Net::Rest::Generic->new(%arguments);
	for my $key (keys %arguments) {
	    is($arguments{$key}, $api->{$key}, "$key returned expected value");
	}
}

TODO: {
    local $TODO = "Net::Rest::Generic Basic Tests";
    defaults();
    basics();
}

1;
