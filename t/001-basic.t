#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 1;

do {
    package Moused::Any::Moose;
    use Any::Moose;

    ::is(any_moose, 'Mouse');
};

