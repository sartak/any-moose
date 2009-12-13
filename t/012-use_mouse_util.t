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
    package My::Package;
    use Any::Moose '::Util' => [qw(does_role)];

    ::ok defined(&does_role);
}

