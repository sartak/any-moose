package Any::Moose;
use strict;
use warnings;

1;

__END__

=head1 NAME

Any::Moose - use Moose or Mouse modules

=head1 SYNOPSIS

=head2 BASIC

    package Class;

    # uses Moose if it's loaded, Mouse otherwise
    use Any::Moose;

=head2 OTHER MODULES

    package Other::Class;
    use Any::Moose;

    # uses Moose::Util::TypeConstraints if the class has loaded Moose,
    # Mouse::Util::TypeConstraints otherwise.
    use Any::Moose '::Util::TypeConstraints';

=head2 COMPLEX USAGE

    package My::Meta::Class;

    # uses Moose if 0.65 is loaded; uses Mouse if 0.14 is loaded; otherwise dies
    use Any::Moose {
        moose_version => '0.65',
        mouse_version => '0.14',
    };

    # uses subtype from Moose::Util::TypeConstraints if the class loaded Moose,
    # subtype from Mouse::Util::TypeConstraints otherwise.
    # similarly for Mo*se::Util's does_role
    use Any::Moose (
        '::Util::TypeConstraints' => ['subtype'],
        '::Util' => ['does_role'],
    );

    # gives you the right class name depending on which Mo*se was loaded
    extends any_moose('::Meta::Class');

=cut

