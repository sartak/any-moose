#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Mouse';
    plan skip_all => 'Mouse not available' if $@;
    plan tests => 1;
}

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Mouse::Meta::Role');

