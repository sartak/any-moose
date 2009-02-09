#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;

BEGIN { delete $ENV{ANY_MOOSE} }

package Test;
BEGIN {
    ::use_ok('Any::Moose');
    ::ok(!Any::Moose::is_moose_loaded(), '... Moose is not loaded');
}

{
    package Foo;
    BEGIN {
        SKIP: {
            eval 'use Moose';
            ::skip 'Moose not installed', 1 if $@;

            ::ok(Any::Moose::is_moose_loaded(), '... Moose is loaded');
        }
    }
}
