package Alien::SWIProlog::Util;
# ABSTRACT: Utilities for SWI-Prolog configuration

use Capture::Tiny qw(capture_stdout);

use constant SWIPL_ARGS => qw(
	--dump-runtime-variables
	-dump-runtime-variables
);

sub get_plvars {
	my ($pl_bin) = @_;
	for my $arg ( SWIPL_ARGS() ) {
		my ($out, $exit) = capture_stdout {
			system( $pl_bin, $arg );
		};
		my $plvars = parse_plvars($out);
		return $plvars;
	}
}

sub plvars_to_props {
	my ($pl, $plvars) = @_;
	return +{
		'swipl-bin' => $pl,
		home => $plvars->{PLBASE},
		cflags => "-I$plvars->{PLBASE}/include",
		libs => "-L$plvars->{PLLIBDIR} $plvars->{PLLIB}",
		rpath => [ $plvars->{PLLIBDIR} ],
		_PLVARS => $plvars,
	}
}

sub parse_plvars {
	my ($pl_dump_output) = @_;
	return +{ $pl_dump_output =~ /^(PL.*?)="(.*)";$/mg };
}

1;
