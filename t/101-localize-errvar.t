#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;
use Any::Moose();

$@ = 'Foo';

Any::Moose::any_moose();

is $@, 'Foo', 'any_moose() does not clear $@';

{
    package X;
    Any::Moose->import;
}

is $@, 'Foo', 'Any::Moose->import does not clear $@';

{
    package X;
    Any::Moose->unimport;
}

is $@, 'Foo', 'Any::Moose->unimport does not clear $@';
