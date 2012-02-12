package Security;
# =============================================================================
# The security mechanism is a Blowfish encrypted token which contains the
# user ID and an expiration time.  The token is hex encoded using CBC and
# stored as a persistent cookie on the user's client.
#
# If you really don't like Blowfish, changing it would be as easy as
# modifying the use statement and changing $AUTH_CRYPT
# =============================================================================
use Crypt::Twofish;
use Crypt::CBC;

use Constants;
use Database;
use Prettify;

use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(
	CheckPassword Encrypt Decrypt LoginProblem
	GenerateAuthToken IsSuperUser GetCurrentUID
);

# =============================================================================
sub CheckPassword
# Generate an authentication token from the supplier User ID.
# =============================================================================
{
	my ($uid, $pass, $dbh) = @_;

	my $stmt = "select UID from user_t where Password=Password('$pass') "
	         . "and UID = '$uid'";

	my @results = RunQuery($stmt, $dbh);
	
	return $#results + 1;
}

# =============================================================================
sub Encrypt
# =============================================================================
{
	my ($data, $key) = @_;

	my $cipher = Crypt::CBC->new( {'key'            => "$key",
	                               'regenerate_key' => 0,
	                               'cipher'         => $AUTH_CRYPT});

	my $ciphertext = $cipher->encrypt_hex($data);
	return $ciphertext;
}

# =============================================================================
sub Decrypt
# =============================================================================
{
	my ($data, $key) = @_;

	my $cipher = Crypt::CBC->new( {'key'            => "$key",
	                               'regenerate_key' => 0,
	                               'cipher'         => $AUTH_CRYPT});

	return $cipher->decrypt_hex($data);
}

# =============================================================================
sub LoginProblem
# Determine if there is a problem with the login.
# =============================================================================
{
	my ($uid, $pwd, $dbh) = @_;

	my $uid = uc $uid;
	my $stmt = "select * from user_t where UPPER(UID)='$uid' and "
	         . "password=Password('$pwd')";

	my @results = RunQuery($stmt, $dbh);

	if ($#results < 0)
	{
		return "Login failed.";
	}

	return undef;
}

# =============================================================================
sub GenerateAuthToken
# Generate an authentication token for the following user.
# =============================================================================
{
	my ($uid) = @_;
	my $expiration = time + $AUTH_LIFETIME;
	my $token = Encrypt("$uid|$expiration", $AUTH_KEY);

	return $token;
}

# =============================================================================
sub IsSuperUser
# =============================================================================
{
	my ($uid, $dbh) = @_;

	my $stmt = "select * from user_t where UPPER(UID)='$uid' and "
	         . "SuperUser = 'Y';";

	my @results = RunQuery($stmt, $dbh);

	return $#results == 0;
}

# =============================================================================
sub GetCurrentUID
# Return the UID of the currently logged in user.
# =============================================================================
{
	my ($dbh) = @_;

	my $token = GetCookie($AUTH_COOKIE);

	if (!$token)
	{
		return undef;
	}
	
	my ($uid, $expiration) = split /\|/, Decrypt($token, $AUTH_KEY);
	my $stmt = "select * from user_t where UPPER(UID)='$uid'";
	my @results = RunQuery($stmt, $dbh);

	if (time > $expiration || $#results < 0)
	{
		return undef;
	}

	return $uid;
}

1;
