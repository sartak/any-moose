#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

BEGIN { delete $ENV{ANY_MOOSE} }

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints' => ['subtype'];

    subtype 'XYZ';
    ::ok(Mouse::Util::TypeConstraints::optimized_constraints()->{XYZ}, 'subtype used Mouse');
};

do {
    package Just::Load::Moose;
    use Moose;
};

do {
    package After::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints';
    use Any::Moose '::Util::TypeConstraints' => ['subtype'];

    subtype 'ABC';
    #::ok(Mouse::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Mouse');
    ::ok(Mouse::Util::TypeConstraints::optimized_constraints()->{ABC}, 'subtype used Mouse');
};

