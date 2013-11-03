#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Deep;
plan tests => 10;
BEGIN{
	use Data::Dumper;
	push(@INC, '/home/shane/Downloads/code/github/p5-net-rest-generic/Net-Rest-Generic/lib/');
}
use_ok( 'Net::Rest::Generic' ) || print "Bail out!\n";

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

	my ($foo, $bar, $baz) = ('one', 'two', 'three');
	$api->$foo->$bar->$baz;
	is(scalar(@{$api->{chain}}), '3', 'Chain contains expected number of elements');
	cmp_deeply(
		$api->{chain},
		[
			'one',
			'two',
			'three',
		],
		'Chain contacts expected elements in the correct order'
	);
}

TODO: {
    local $TODO = "Net::Rest::Generic Basic Tests";
    defaults();
    basics();
}

1;
