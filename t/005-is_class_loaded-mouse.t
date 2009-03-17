#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

plan tests => 2;

{
    package MyFoo;
    use Any::Moose;
}

package main;
ok(Any::Moose::is_class_loaded('Mouse'));
ok(!Any::Moose::is_class_loaded('Meese'));

