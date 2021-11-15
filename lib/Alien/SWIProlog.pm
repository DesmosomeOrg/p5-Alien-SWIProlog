package Alien::SWIProlog;
# ABSTRACT: Alien package for the SWI-Prolog Prolog interpreter

use strict;
use warnings;

use base qw(Alien::Base);
use Role::Tiny::With qw( with );
use Alien::SWIProlog::Util;

with 'Alien::Role::Dino';

1;
=head1 SEE ALSO

L<SWI-Prolog|https://www.swi-prolog.org/>

=cut
