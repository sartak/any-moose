#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'require Moose';
    plan skip_all => 'Moose not available' if $@;
    plan tests => 1;
}

{
    package My::Package;
    use Any::Moose '::Util' => [qw(does_role)];

    ::ok defined(&does_role);
}

