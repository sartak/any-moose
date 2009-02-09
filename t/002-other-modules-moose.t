#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

BEGIN { delete $ENV{ANY_MOOSE} }

do {
    package Just::Load::Moose;
    use Moose;
};

do {
    package Moosed::Any::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints' => ['subtype'];

    subtype 'XYZ';
    ::ok(Moose::Util::TypeConstraints::find_type_constraint('XYZ'), 'subtype used Moose');
};

do {
    package After::Moose;
    use Any::Moose;
    use Any::Moose '::Util::TypeConstraints';
    use Any::Moose '::Util::TypeConstraints' => ['subtype'];

    subtype 'ABC';
    ::ok(Moose::Util::TypeConstraints::find_type_constraint('ABC'), 'subtype used Moose');
};

