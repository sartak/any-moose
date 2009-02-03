#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
require Any::Moose;

my @tests = (
    ''            => 'Moose',
    'Moose'       => 'Moose',
    'Mouse'       => 'Moose',
    'Moose::Util' => 'Moose::Util',
    'Mouse::Util' => 'Moose::Util',
    '::Util'      => 'Moose::Util',
    'Util'        => 'Moose::Util',
);

plan tests => @tests / 2;

while (my ($fragment, $expected) = splice @tests, 0, 2) {
    my $got = Any::Moose::_canonicalize_fragment($fragment);
    is($got, $expected, "Canonicalized '$fragment'");
}

