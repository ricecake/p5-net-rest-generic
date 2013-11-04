package Net::Rest::Generic;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Want;
use URI;
use Net::Rest::Generic::Utility;
=head1 NAME

Net::Rest::Generic - The great new Net::Rest::Generic!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Net::Rest::Generic;

    my $foo = Net::Rest::Generic->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

sub new {
	my ($class, %params) = @_;
	my %defaults = (
		mode   => 'get',
		scheme => 'HTTPS',
	);
	my $self = {
		chain  => [],
		_params => \%params,
	};
	map { $self->{$_} = delete $self->{_params}{$_} } grep { defined($self->{_params}{$_}) } qw(mode scheme host port base);
	while (my ($k, $v) = each %defaults) {
		$self->{$k} ||= $v;
	}
        $self->{uri} = URI->new();
        $self->{uri}->scheme($self->{scheme});
        $self->{uri}->host($self->{host});
        $self->{uri}->port($self->{port}) if exists $self->{port};
	return bless $self, $class;
}


sub AUTOLOAD {
	my $self = shift;

	our $AUTOLOAD;
	my ($key) = $AUTOLOAD =~ /.*::([\w_]+)/o;
	return if ($key eq 'DESTROY');
        print "$key\n";

	push @{ $self->{chain} }, $key;
        my $args;
        if (ref($_[0])) {
                $args = $_[0];
        }
        else {
                push @{ $self->{chain} }, @_;
        }
	if (want('OBJECT') || want('VOID')) {
		return $self;
	}
        
	my $url = join('/', grep {$_} @{[$self->{base}]}, @{ $self->{chain} });
        $self->{chain} = [];
        $self->{uri}->path($url);
        
        return Net::Rest::Generic::Utility::_doRestCall($self->{method}, $self->{uri}->as_string;, $args);
}

sub meta {
        my ($self, @labels) = @_;
        push @{ $self->{chain} }, @labels;
        return $self;
}

=head1 AUTHOR

Sebastian Green-Husted,Shane Utt, C<< <ricecake at tfm.nu> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-rest-generic at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-Rest-Generic>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Rest::Generic


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-Rest-Generic>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-Rest-Generic>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-Rest-Generic>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-Rest-Generic/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Sebastian Green-Husted,Shane Utt.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Net::Rest::Generic
