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

my %arguments = (
	mode   => 'post',
	scheme => 'https',
	host   => 'perl.org',
	port   => '8080',
	base   => 'version1'
);

my $api = Net::Rest::Generic->new(mode => 'post');
isa_ok(
	$api,
	'Net::Rest::Generic',
	'Create with a HASHREF succeeded and it'
);
$api = Net::Rest::Generic->new(%arguments);
isa_ok(
	$api,
	'Net::Rest::Generic',
	'Create with a HASH succeeded and it'
);
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

1;
