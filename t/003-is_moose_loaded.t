#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Mouse ()';
    plan skip_all => "Mouse unavailable: $@" if $@;
    plan tests => 3;
}

package Test;
BEGIN {
    ::use_ok('Any::Moose');
    ::ok(!Any::Moose::_is_moose_loaded(), '... Moose is not loaded');
}

{
    package Foo;
    BEGIN {
        SKIP: {
            eval 'use Moose ()';
            ::skip "Moose unavailable: $@", 1 if $@;

            ::ok(Any::Moose::_is_moose_loaded(), '... Moose is loaded');
        }
    }
}
