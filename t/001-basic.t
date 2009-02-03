#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

do {
    package Moused::Any::Moose;
    use Any::Moose;

    ::ok(__PACKAGE__->can('meta'), 'Mo*se was installed');
    ::like(__PACKAGE__->meta, /^Mouse/, 'Mouse was installed');

    ::is(any_moose, 'Mouse');
    ::is(any_moose('::Util::TypeConstraints'), 'Mouse::Util::TypeConstraints');

    require Moose;

    ::is(any_moose, 'Mouse', 'still Mouse even if Moose is loaded');
};

do {
    package Moosed::Any::Moose;
    use Any::Moose;

    ::is(any_moose, 'Moose');
    ::is(any_moose('::Util::TypeConstraints'), 'Moose::Util::TypeConstraints');
};

