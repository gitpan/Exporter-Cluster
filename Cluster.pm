package Exporter::Cluster;
######################################################################
##                                                                  ##
##  Package:  Cluster.pm                                            ##
##  Author:   D. Hageman <dhageman@dracken.com>                     ##
##                                                                  ##
##  Description:                                                    ##
##                                                                  ##
##  Exporter::Cluster is a module designed to work with Exporter    ##
##  to bundle or 'cluster' the importing of several modules.        ##
##                                                                  ##
######################################################################

##==================================================================##
##  Libraries and Variables                                         ##
##==================================================================##

require 5.6.0;

use warnings;

our $VERSION = "0.2.0";

##==================================================================##
##  Function(s)                                                     ##
##==================================================================##

##----------------------------------------------##
##  import                                      ##
##----------------------------------------------##
##----------------------------------------------##
sub import
{
	my $self = shift;
	
	## We need to find out who is calling us so we can use that
	## as the destination of the symbol munging.
	my $caller = caller;
	
	## Loop through all of the elements of the EXPORT_CLUSTER hash.
	foreach( keys( %{ "$self\::EXPORT_CLUSTER" } ) )
	{
		## Grab the arguments to pass into the import function.  We
		## clean them up a bit so they can pass nicely into our
		## eval.
		my $arguments = join( ",", @{ ${ "$self\::EXPORT_CLUSTER" }{ $_ } } );
		
		## The magic happens here ... we require the package we are
		## wanting to 'use', change our calling space and import
		## the symbols into that calling space.
		eval "require $_; package $caller; $_->import( $arguments );";

		## If we have an error, go ahead and display it.
		die( @_ ) if ( @_ );
	}
	
	return;
}		

##==================================================================##
##  End of Code                                                     ##
##==================================================================##
1;

##==================================================================##
##  Plain Old Documentation (POD)                                   ##
##==================================================================##

__END__

=head1 NAME

Exporter::Cluster - Implements a 'bundled' import method for modules

=head1 SYNOPSIS

use Exporter::Cluster;

=head1 DESCRIPTION

Exporter::Cluster is designed to allow the user to develop a binding
package that allows multiple packages to be imported into the
symbol table with single 'use' command.  This module was created from 
the observation of the general trend of Perl packages growing in
complexity as new technology is developed and Perl interfaces
are designed to interact with this technology.  This is not a 
general use module!  It has been designed mainly for use by developers
who are trying to implement a sane interface to their work, but 
still attempt to use good coding practices such as code seperation
and modular design.

=head1 BUGS

No known bugs at this time.

=head1 AUTHOR

D. Hageman E<lt>dhageman@dracken.comE<gt>

=head1 SEE ALSO

L<Exporter>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2002 D. Hageman (Dracken Technologies).
All rights reserved.

This program is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself. 

=cut

