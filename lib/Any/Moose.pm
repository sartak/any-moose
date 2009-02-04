package Any::Moose;
use strict;
use warnings;

sub import {
    my $self = shift;
    my $pkg  = caller;

    # first options are for Mo*se
    unshift @_, 'Moose' if !@_ || ref($_[0]);

    while (my $module = shift) {
        my $options = @_ && ref($_[0]) ? shift : [];

        $options = $self->_canonicalize_options(
            module  => $module,
            options => $options,
            package => $pkg,
        );

        $self->_install_module($options);
    }

    # give them any_moose too
    no strict 'refs';
    *{$pkg.'::any_moose'} = \&any_moose;
}

sub unimport {
    my $self = shift;
    my $pkg  = caller;

    my $backer = _backer_of($pkg);

    eval "package $pkg;\n"
       . '$backer->unimport(@_);';
}

sub _backer_of {
    my $pkg = shift;

    return 'Mouse' if $INC{'Mouse.pm'}
                   && Mouse::Meta::Class->_metaclass_cache($pkg);
    return 'Mouse::Role' if $INC{'Mouse/Role.pm'}
                         && Mouse::Meta::Role->_metaclass_cache($pkg);

    if ($INC{'Class/MOP.pm'}) {
        my $meta = Class::MOP::get_metaclass_by_name($pkg);
        if ($meta) {
            return 'Moose::Role' if $meta->isa('Moose::Meta::Role');
            return 'Moose'       if $meta->isa('Moose::Meta::Class');
        }
    }

    return undef;
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
    $options{module}  = any_moose($args{module}, $args{package});

    return \%options;
}

sub _install_module {
    my $self    = shift;
    my $options = shift;

    my $module = $options->{module};
    (my $file = $module . '.pm') =~ s{::}{/}g;

    require $file;

    eval "package $options->{package};\n"
       . '$module->import(@{ $options->{imports} });';
}

sub any_moose {
    my $fragment = _canonicalize_fragment(shift);
    my $package  = shift || caller;

    # Mouse gets first dibs because it doesn't introspect existing classes

    if ((_backer_of($package)||'') =~ /^Mouse/) {
        $fragment =~ s/^Moose/Mouse/;
        return $fragment;
    }

    return $fragment if (_backer_of($package)||'') =~ /^Moose/;

    # If we're loading up the backing class...
    if ($fragment eq 'Moose' || $fragment eq 'Moose::Role') {
        $fragment =~ s/Moose/Mouse/ if !$INC{'Class/MOP.pm'};
        return $fragment;
    }

    require Carp;
    Carp::croak "Neither Moose nor Mouse backs the '$package' package.";
}

sub _canonicalize_fragment {
    my $fragment = shift;

    return 'Moose' if !defined($fragment);

    # any_moose("::Util") -> any_moose("Moose::Util")
    $fragment =~ s/^::/Moose::/;

    # any_moose("Mouse::Util") -> any_moose("Moose::Util")
    $fragment =~ s/^Mouse\b/Moose/;

    # any_moose("Util") -> any_moose("Moose::Util")
    $fragment =~ s/^(?!Moose)/Moose::/;

    # any_moose("Moose::") (via any_moose("")) -> any_moose("Moose")
    $fragment =~ s/^Moose::$/Moose/;

    return $fragment;
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
    # XXX: not implemented yet!
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

