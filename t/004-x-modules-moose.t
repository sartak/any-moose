#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Moose; require MooseX::Types';
    plan skip_all => 'Moose or MooseX::Types not available' if $@;
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

