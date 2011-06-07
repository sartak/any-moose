use strict;
use Test::More tests => 1;
use_ok 'Any::Moose';

show_version($_) for qw/
    Mouse
    MouseX::Types
    Moose
    Class::MOP
    MooseX::Types
/;

sub show_version {
    my $klass = shift;
    if (eval "use $klass (); 1") {
        no strict 'refs';
        diag "$klass: " . ${"${klass}::VERSION"};
    } else {
        diag "$klass unavailable: $@";
    }
}
