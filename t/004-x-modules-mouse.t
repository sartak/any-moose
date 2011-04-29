#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    plan skip_all => 'Mouse or MouseX::Types 0.03 not available' unless eval "require Mouse; require MouseX::Types 0.03;";
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

