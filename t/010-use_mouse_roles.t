#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Mouse::Meta::Role');
