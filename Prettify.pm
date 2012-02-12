package Prettify;

use Constants;
use Gosh;

use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(
	RaiseError
	PrintHeader
	GetCookie SetCookie DeleteCookie
	Redirect
	PrintFooter
);

$HEADER = 0;

# =============================================================================
sub RaiseError
# Throw out an HTML formatted error and halt execution.  It's like a Java
# exeception, only not as robust, but less annoying.
# =============================================================================
{
	my ($message) = @_;

	my %gosh;
	$gosh{message} = $message;
	$gosh{file} = $0;

	PrintHeader();
	WriteGosh($GOSH_ERROR, %gosh);
	exit;
}

# =============================================================================
sub PrintHeader
# Determine if we need to print a Content-Type header or not.
# =============================================================================
{
	if($HEADER)
	{
		return;
	}

	print "Content-type: text/html\n\n";
	$HEADER = 1;
}

# =============================================================================
sub PrintFooter
# =============================================================================
{
	$HEADER = 0;
}

# =============================================================================
sub GetCookie
# =============================================================================
{
	my ($cookie) = @_;

	foreach (split /;/, $ENV{HTTP_COOKIE})
	{
		my ($name, $value) = split /=/, $_, 2;

		if ($name eq $cookie)
		{
			return $value;	
		}
	}

	return undef;
}

# =============================================================================
sub SetCookie
# =============================================================================
{
	my ($name, $value) = @_;

	my $expire = CGI::expires('+1y');
	my $cookie = "Set-Cookie: $name=$value; expires=$expire; path=/; "
	           . "domain=$ENV{SERVER_NAME}\n";
	
	print $cookie;
}

# =============================================================================
sub DeleteCookie
# =============================================================================
{
	my ($name) = @_;

	my $value = GetCookie($name);

	if (!$value)
	{
		return;
	}

	my $expire = CGI::expires('-1y');
	my $cookie = "Set-Cookie: $name=$value; expires=$expire; path=/; "
	           . "domain=$ENV{SERVER_NAME}\n";

	print $cookie;
}

# =============================================================================
sub Redirect
# =============================================================================
{
	my ($url) = @_;

	print "Location: $url\n\n";
}

1;
