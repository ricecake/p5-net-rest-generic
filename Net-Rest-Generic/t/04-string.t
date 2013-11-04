!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Deep;
plan tests => 13;

use_ok( 'Net::Rest::Generic' ) || print "Bail out!\n";