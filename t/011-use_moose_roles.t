#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

use Moose ();

{
    package My::Role;
    use Any::Moose '::Role';
}

isa_ok(My::Role->meta, 'Moose::Meta::Role');
