package Alien::SWIProlog;
# ABSTRACT: Alien package for the SWI-Prolog Prolog interpreter

use strict;
use warnings;

use base qw(Alien::Base);
use Role::Tiny::With qw( with );
use Class::Method::Modifiers;
use Alien::SWIProlog::Util;
use Env qw(
	$SWI_HOME_DIR
);

with 'Alien::Role::Dino';

before import => sub {
	my $class = shift;

	$SWI_HOME_DIR = $class->runtime_prop->{home};
	my @swi_lib_dirs = $class->rpath;
	require DynaLoader;
	unshift @DynaLoader::dl_library_path, @swi_lib_dirs;
	my ($dlfile) = DynaLoader::dl_findfile('-lswipl');
	DynaLoader::dl_load_file($dlfile);
};

1;
=head1 SEE ALSO

L<SWI-Prolog|https://www.swi-prolog.org/>

=cut
