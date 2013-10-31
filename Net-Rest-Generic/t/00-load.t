#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Net::Rest::Generic' ) || print "Bail out!\n";
}

diag( "Testing Net::Rest::Generic $Net::Rest::Generic::VERSION, Perl $], $^X" );
