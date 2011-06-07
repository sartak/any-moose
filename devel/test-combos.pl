#!/usr/bin/env perl
use 5.14.0;
use warnings;
use Data::PowerSet 'powerset';

my @all_modules = qw(Mouse MouseX::Types Moose MooseX::Types);

my %results;

for my $modules (@{ powerset(@all_modules) }) {
    my $list = join ',', @$modules;

    say '=' x 60;
    say "RUNNING WITHOUT $list";
    say '=' x 60;

    $ENV{PERL5OPT} = "-MTest::Without::Module=$list";
    system("prove");

    push @{ $results{ $? >> 8 ? "NOT OK" : "OK" } }, $list;
}

for my $result (sort keys %results) {
    my @modules = @{ $results{$result} };
    say "$result when testing without:";
    say "* $_" for @modules;
    say '';
}

__END__

... test results ...

NOT OK when testing without:
* Mouse,MouseX::Types,Moose,MooseX::Types
* Mouse,Moose,MooseX::Types
* Mouse,MouseX::Types,Moose
* Mouse,Moose

OK when testing without:
* MouseX::Types,Moose,MooseX::Types
* Moose,MooseX::Types
* Mouse,MouseX::Types,MooseX::Types
* MouseX::Types,MooseX::Types
* Mouse,MooseX::Types
* MooseX::Types
* MouseX::Types,Moose
* Moose
* Mouse,MouseX::Types
* MouseX::Types
* Mouse
* 
