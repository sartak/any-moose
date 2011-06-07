#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Moose ()';
    plan skip_all => "Moose unavailable: $@" if $@;
    plan tests => 2;
}

do {
    package Moosed::Any::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

    subtype 'XYZ' => as 'Int';
    ::ok(Moose::Util::TypeConstraints::find_type_constraint('XYZ'), 'subtype used Moose');
};

do {
    package After::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints';
    use Any::Moose '::Util::TypeConstraints' => ['subtype', 'as'];

    subtype 'ABC' => as 'Int';
    ::ok(Moose::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Moose');
};

