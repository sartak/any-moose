#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { delete $ENV{ANY_MOOSE} }

BEGIN {
    eval 'use Moose ()';
    plan skip_all => "Moose unavailable: $@" if $@;
    plan tests => 21;
}

package MyClass;
use Any::Moose;

package main;

ok(Any::Moose::is_class_loaded('Moose'), 'Moose is loaded');
ok(Any::Moose::is_class_loaded('MyClass'), 'MyClass is loaded');
ok(!Any::Moose::is_class_loaded('NonexistentPackage'), 'NonexistentPackage is not loaded');

push @INC, 't/lib';

ok(!Any::Moose::is_class_loaded('AnyMooseTest'), 'AnyMooseTest not yet loaded');
ok(Any::Moose::load_class('AnyMooseTest'), 'Loading AnyMooseTest');
ok(Any::Moose::is_class_loaded('AnyMooseTest'), 'AnyMooseTest now loaded');

is(eval { Any::Moose::load_class('NonexistentTest'); 1 }, undef, 'load_class on nonexistent module fails');
ok(!Any::Moose::is_class_loaded('NonexistentTest'), 'and it is still not loaded');

like(Any::Moose::class_of('MyClass'), qr/Moose::Meta::Class=HASH/, 'metaclass check');
is(Any::Moose::class_of('NonexistentTest'), undef, 'class_of nonexistent class is undef');
like(Any::Moose::class_of(MyClass->new), qr/Moose::Meta::Class=HASH/, 'metaclass check via object');

like(Any::Moose::get_metaclass_by_name('MyClass'), qr/Moose::Meta::Class=HASH/, 'metaclass check');
is(Any::Moose::get_metaclass_by_name('NonexistentTest'), undef, 'class_of nonexistent class is undef');
is(Any::Moose::get_metaclass_by_name(MyClass->new), undef, 'get_metaclass_by_name via object returns undef');

my %metaclasses = map { $_->name => $_ } Any::Moose::get_all_metaclass_instances();
is($metaclasses{MyClass}, MyClass->meta);
is($metaclasses{AnyMooseTest}, AnyMooseTest->meta);
is($metaclasses{NonexistentTest}, undef);

is((grep { $_ eq 'MyClass' } Any::Moose::get_all_metaclass_names()), 1);
is((grep { $_ eq 'AnyMooseTest' } Any::Moose::get_all_metaclass_names()), 1);
is((grep { $_ eq 'NonexistentTest' } Any::Moose::get_all_metaclass_names()), 0);

my $c = Any::Moose::load_first_existing_class('Any::Moose::No::Such::Module', 'strict');
is $c, 'strict', 'load_first_existing_class';
