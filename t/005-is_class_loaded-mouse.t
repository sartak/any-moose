#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Mouse';
    plan skip_all => 'Mouse not available' if $@;
    plan tests => 2;
}

{
    package MyFoo;
    use Any::Moose;
}

package main;
ok(Any::Moose::is_class_loaded('Mouse'));
ok(!Any::Moose::is_class_loaded('Meese'));

