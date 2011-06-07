#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Moose ()';
    plan skip_all => "Moose unavailable: $@" if $@;
    plan tests => 1;
}

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Moose::Meta::Role');
