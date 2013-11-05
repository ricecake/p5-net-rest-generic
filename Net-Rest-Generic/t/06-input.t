#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Deep;
plan tests => 10;

use_ok( 'Net::Rest::Generic' ) || print "Bail out!\n";
use_ok( 'Net::Rest::Generic::Error' ) || print "Bail out!\n";
