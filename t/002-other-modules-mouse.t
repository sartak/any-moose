#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Mouse';
    plan skip_all => 'Mouse not available' if $@;
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
    my $loaded_moose;
    BEGIN { $loaded_moose = eval 'require Moose' }
    skip "Moose required for these tests to be useful" => 1 unless $loaded_moose;

    do {
        package After::Moose;
        use Any::Moose;
        use Any::Moose '::Util::TypeConstraints';
        use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

        subtype 'ABC' => as 'Int';
        ::ok(Mouse::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Mouse');
    };
};

