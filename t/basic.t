use Test2::V0;
use Test::Alien;
use Test::Alien::Diag;
use Alien::SWIProlog;

use DynaLoader;
use Path::Tiny;

my $distdir = path(Alien::SWIProlog->runtime_prop->{distdir});
my $swi_home_dir = $distdir->child( qw(lib swipl) );
my ($swi_lib_dir) = grep { $_->is_dir && $_ !~ /swiplserver/ }
	$swi_home_dir->child('lib')->children();

$ENV{SWI_HOME_DIR} = $swi_home_dir;
unshift @DynaLoader::dl_library_path, $swi_lib_dir;

DynaLoader::dl_load_file((DynaLoader::dl_findfile('-lswipl'))[0]);

alien_diag 'Alien::SWIProlog';
alien_ok 'Alien::SWIProlog';

my $xs = do { local $/; <DATA> };
xs_ok { xs => $xs,  verbose => 1 }, with_subtest {
	my($module) = @_;
	ok $module->init, 'Initialises SWI-Prolog';
};

done_testing;
__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define PL_version _SWI_PL_version
#include <SWI-Prolog.h>

int
init(const char *class)
{
	int PL_argc;
	char empty_arg[] = "";

	char* PL_argv[1];
	PL_argv[PL_argc++] = empty_arg;

	return PL_initialise(PL_argc, PL_argv);
}

MODULE = TA_MODULE PACKAGE = TA_MODULE

int init(class);
	const char *class;
