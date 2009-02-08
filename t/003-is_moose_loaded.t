#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;

package Test;
BEGIN {
    ::use_ok('Any::Moose');
    ::ok(!Any::Moose::is_moose_loaded(), '... Moose is not loaded');
}

{
    package Foo;
    use Moose;
}

BEGIN {
    ::ok(Any::Moose::is_moose_loaded(), '... Moose is loaded');
}
