#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
require Any::Moose;

BEGIN { delete $ENV{ANY_MOOSE} }

my @tests = (
    ''                => 'Moose',

    'Moose'           => 'Moose',
    'Mouse'           => 'Moose',

    'Moose::Util'     => 'Moose::Util',
    'Mouse::Util'     => 'Moose::Util',
    '::Util'          => 'Moose::Util',
    'Util'            => 'Moose::Util',

    'MooseX::Types'   => 'MooseX::Types',
    'MouseX::Types'   => 'MooseX::Types',
    'X::Types'        => 'MooseX::Types',

    'Moose::X::Types' => 'Moose::X::Types',
    'Mouse::X::Types' => 'Moose::X::Types',
    '::X::Types'      => 'Moose::X::Types',
);

plan tests => @tests / 2;

while (my ($fragment, $expected) = splice @tests, 0, 2) {
    my $got = Any::Moose::_canonicalize_fragment($fragment);
    is($got, $expected, "Canonicalized '$fragment'");
}

