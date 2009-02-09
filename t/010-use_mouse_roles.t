#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

BEGIN { delete $ENV{ANY_MOOSE} }

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Mouse::Meta::Role');
