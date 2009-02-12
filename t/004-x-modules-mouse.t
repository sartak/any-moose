#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
plan skip_all => 'MouseX::Types not available' unless eval "require MouseX::Types; 1;";
plan tests => 2;

BEGIN { delete $ENV{ANY_MOOSE} }

do {
    package Moused::Any::Moose;
    use Any::Moose;
    use Any::Moose 'X::Types';

    ::ok(MouseX::Types->can('import'), 'MouseX::Types');
};

SKIP: {
    my $loaded_moose;
    BEGIN { $loaded_moose = eval 'require Moose' }
    skip "Moose required for these tests to be useful" => 1 unless $loaded_moose;

    do {
        package After::Moose;
        use Any::Moose;
        use Any::Moose 'X::Types';

        ::ok(MouseX::Types->can('import'), 'MouseX::Types');
    };
};

