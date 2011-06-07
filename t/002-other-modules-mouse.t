#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Mouse ()';
    plan skip_all => "Mouse unavailable: $@" if $@;
    plan tests => 2;
}

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

    subtype 'XYZ' => as 'Int';
    ::ok(Mouse::Util::TypeConstraints::find_type_constraint('XYZ'), 'subtype used Mouse');
};

SKIP: {
    eval 'use Moose ()';
    skip "Moose unavailable: $@" => 1 if $@;

    do {
        package After::Moose;
        use Any::Moose;
        use Any::Moose '::Util::TypeConstraints';
        use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

        subtype 'ABC' => as 'Int';
        ::ok(Mouse::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Mouse');
    };
};

