#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Deep;
plan tests => 4;

use_ok( 'Net::Rest::Generic::Error' ) || print "Bail out!\n";

my $error = Net::Rest::Generic::Error->throw(
	category => 'http',
	message  => 'dang it',
	type     => '501',
);

my $category = $error->category;
is($category, 'http', 'error object returned expected category');

my $message  = $error->message;
is($message, 'dang it', 'error object returned expected message');

my $type     = $error->type;
is($type, '501', 'error object returned expected type');

1;
