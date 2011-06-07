#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Moose ()';
    plan skip_all => "Moose unavailable: $@" if $@;
    eval 'use MooseX::Types ()';
    plan skip_all => "Moose::Types unavailable: $@" if $@;

    plan tests => 2;
}

do {
    package Moosed::Any::Moose;
    use Any::Moose;
    use Any::Moose 'X::Types';

    ::ok(MooseX::Types->can('import'), 'MooseX::Types');
};

do {
    package After::Moose;
    use Any::Moose;
    use Any::Moose 'X::Types';

    ::ok(MooseX::Types->can('import'), 'MooseX::Types');
};

