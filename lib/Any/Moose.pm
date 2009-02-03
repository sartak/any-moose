package Any::Moose;
use strict;
use warnings;

sub import {
    my $self = shift;
    my $pkg  = caller;

    # first options are for Mo*se
    unshift @_, 'Moose' if ref($_[0]);

    while (my $module = shift) {
        my $options = ref($_[0]) ? shift : [];
        $options = _canonicalize_options(
            module  => $module,
            options => $options,
            package => $pkg,
        );

        _install_module($options);
    }
}

sub _canonicalize_options {
    my $self = shift;
    my %args = @_;

    my %options;
    if (ref($args{options}) eq 'HASH') {
        %options = %{ $args{options} };
    }
    else {
        %options = (
            imports => $args{options},
        );
    }

    $options{package} = $args{package};
    $options{module}  = any_moose($args{module}, $options{package});

    return \%options;
}

sub any_moose {
    my $fragment = shift;
    my $package  = shift || caller;

    # any_moose("::Util") -> any_moose("Moose::Util")
    $fragment =~ s/^::/Moose::/;

    # any_moose("Mouse::Util") -> any_moose("Moose::Util")
    $fragment =~ s/^Mouse::/Moose::/;

    # any_moose("Util") -> any_moose("Moose::Util")
    $fragment =~ s/^(?!Moose::/)Moose::/;

    # any_moose("Moose::") (via any_moose("")) -> any_moose("Moose")
    $fragment =~ s/^Moose::$/Moose/;

    # Mouse gets first dibs because it doesn't introspect existing classes
    if (Mouse::Meta::Class::_metaclass_cache($package)) {
        $fragment =~ s/^Moose/Mouse/;
        return $fragment;
    }

    return $fragment if Class::MOP::does_metaclass_exist($package);

    require Carp;
    Carp::croak "Neither Moose nor Mouse backs the '$package' package.";
}

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

