#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Moose;';
    plan skip_all => 'Moose not available' if $@;
    plan tests => 2;
}

package MyFoo;
use Any::Moose;
::ok Any::Moose::is_class_loaded('Moose');
::ok !Any::Moose::is_class_loaded('Meese');

