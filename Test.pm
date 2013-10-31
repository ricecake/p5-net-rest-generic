package Test;
use Want;
use Data::Dumper qw(Dumper);

sub AUTOLOAD {
	my $self = shift;

	our $AUTOLOAD;
	my ($key) = $AUTOLOAD =~ /.*::([\w_]+)/o;
	return if ($key eq 'DESTROY');

	if (want('OBJECT') || want('VOID')) {
		push @{ $self->{chain} }, $key;
		if (@_ == 1) {
			push @{ $self->{chain} }, $_[0];
		}
		return $self;
	}

	my $args = ref($_[0]) ? $_[0] : {@_};

	my $url = join('/', @{ $self->{chain} }, $key);
	my $method = $self->{mode}   || '';
	my $scheme = $self->{scheme} || '';
	my $host   = $self->{host}   || '';
	my $port = $self->{port} ? ":" . $self->{port}       : '';
	my $base = $self->{base} ? "/" . $self->{base} . "/" : '';

	return "$method $scheme://$host$port$base$url";
}

sub new {
	my ($class, %params) = @_;
	my %defaults = (
		mode   => 'get',
		scheme => 'http',
	);
	my $self = {
		_chain  => [],
		_params => \%params
	};
	map { $self->{$_} = delete $self->{_params}{$_} } grep { defined($self->{_params}{$_}) } qw(mode scheme host port base);
	while (my ($k, $v) = each %defaults) {
		$self->{$k} ||= $v;
	}
	return bless $self, $class;
}

1;

