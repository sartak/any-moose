#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

BEGIN { delete $ENV{ANY_MOOSE} }

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

    subtype 'XYZ' => as 'Int';
    ::ok(Mouse::Util::TypeConstraints::optimized_constraints()->{XYZ}, 'subtype used Mouse');
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
        #::ok(Mouse::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Mouse');
        ::ok(Mouse::Util::TypeConstraints::optimized_constraints()->{ABC}, 'subtype used Mouse');
    };
};

