#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Mouse ()';
    plan skip_all => "Mouse unavailable: $@" if $@;
    eval 'use MouseX::Types 0.03';
    plan skip_all => "Mouse::Types 0.03 unavailable: $@" if $@;

    plan tests => 2;
}

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose 'X::Types';

    ::ok(MouseX::Types->can('import'), 'MouseX::Types');
};

SKIP: {
    eval 'use Moose ()';
    skip "Moose unavailable: $@" => 1 if $@;
    eval 'use MooseX::Types ()';
    skip "MooseX::Types unavailable: $@" => 1 if $@;

    do {
        package After::Moose;
        use Any::Moose;
        use Any::Moose 'X::Types';

        ::ok(MouseX::Types->can('import'), 'MouseX::Types');
    };
};

