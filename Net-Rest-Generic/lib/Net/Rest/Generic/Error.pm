package Net::Rest::Generic::Error;

use 5.006;
use strict;
use warnings FATAL => 'all';

sub throw {
	my $class = shift;
	my %args = ref($_[0]) ? %{$_[0]} : @_;
	#assume its something wrong with Net::Rest::Generic unless told otherwise.
	$args{type}     = $args{type}     ? $args{type}     : 'fail';
	$args{category} = $args{category} ? $args{category} : 'object';
	$args{message}  = $args{message}  ? $args{message}  : 'unknown';
	my $self  = {
		error_type     => $args{type},
		error_category => $args{category},
		error_message  => $args{message},
	};
	return bless $self, $class;
}

sub type {
	my $self = shift;
	return $self->{type};
}

sub category {
	my $self = shift;
	return $self->{category};
}

sub message {
	my $self = shift;
	return $self->{message};
}

1;
