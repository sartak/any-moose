#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Mouse ()';
    plan skip_all => "Mouse unavailable: $@" if $@;
    plan tests => 1;
}

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Mouse::Meta::Role');

