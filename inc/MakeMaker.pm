package inc::MakeMaker;
use Moose;
extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

use namespace::autoclean;

override _build_WriteMakefile_dump => sub {
  my ($self) = @_;

  my $str = super;

  $str .= ";\n\n";

  $str .= <<'END_NONSENSE';
$WriteMakefileArgs{PREREQ_PM} ||= {};

if (eval { require Moose }) {
  # we have any version of Moose; good enough! -- rjbs, 2011-09-15
} else {
  # No Moose?  Well, we need *something* to test with, so we'll ask for the
  # lighter-weight one, Mouse. -- rjbs, 2011-09-15
  $WriteMakefileArgs{PREREQ_PM}{Mouse} = '0.40';
}

END_NONSENSE

  return $str;
};

1;
