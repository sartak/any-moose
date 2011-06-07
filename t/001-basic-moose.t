#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Moose ()';
    plan skip_all => "Moose unavailable: $@" if $@;
    plan tests => 9;
}

do {
    package Moosed::Any::Moose;
    use Any::Moose;

    ::ok(__PACKAGE__->can('meta'), 'Mo*se was installed');
    ::like(__PACKAGE__->meta, qr/^Moose/, 'Moose was installed');

    ::is(any_moose, 'Moose');
    ::is(any_moose('::Util::TypeConstraints'), 'Moose::Util::TypeConstraints');

    ::is(any_moose, 'Moose', 'still Moose even if Moose is loaded');

    no Any::Moose;
};

ok(!Moosed::Any::Moose->can('has'), "has was unimported");

do {
    package After::Moose;
    use Any::Moose;

    ::is(any_moose, 'Moose');
    ::is(any_moose('::Util::TypeConstraints'), 'Moose::Util::TypeConstraints');

    no Any::Moose;
};

ok(!After::Moose->can('has'), "has was unimported");
