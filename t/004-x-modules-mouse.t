#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    plan skip_all => 'MouseX::Types not available' unless eval "require MouseX::Types";
    plan tests => 2;
}

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose 'X::Types';

    ::ok(MouseX::Types->can('import'), 'MouseX::Types');
};

SKIP: {
    my $loaded_moose;
    BEGIN { $loaded_moose = eval 'require Moose; require MooseX::Types' }
    skip "Moose and MooseX::Types required for these tests to be useful" => 1 unless $loaded_moose;

    do {
        package After::Moose;
        use Any::Moose;
        use Any::Moose 'X::Types';

        ::ok(MouseX::Types->can('import'), 'MouseX::Types');
    };
};

