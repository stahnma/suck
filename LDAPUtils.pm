package LDAPUtils;

use Net::LDAP;

use Constants;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(
	GetLDAPHandle
	GetUserEntry
	AuthUser
	LoginSuccessful
);

# ====================================================================================================
sub GetLDAPHandle
# ====================================================================================================
{
	my $ldap = Net::LDAP->new( $LDAP_HOST );
	
	if ($ldap)
	{
		$ldap->bind ( $LDAP_USER, password => $LDAP_PWD);
	}

	return $ldap;
}

# ====================================================================================================
sub GetUserEntry
# ====================================================================================================
{
	my ($uid, $ldap) = @_;

	my $mesg = $ldap->search( base => $LDAP_BASEDN,
				  filter => "(uid=$uid)");

	if ($mesg->count == 1)
	{
		return $mesg->entry(0);
	}

	return undef;
}

# ====================================================================================================
sub AuthUser
# ====================================================================================================
{
	my ($dn, $pwd, $ldap) = @_;

	if (!$ldap)
	{
		return 0;
	}

	my $mesg = $ldap->bind( $dn, password => $pwd );

	return !$mesg->is_error();
}

# ====================================================================================================
sub LoginSuccessful
# ====================================================================================================
{
	my ($uid, $pwd) = @_;

	my $ldap = GetLDAPHandle();

	if ($ldap)
	{
		my $entry = GetUserEntry($uid, $ldap);

		if ($entry)
		{
			return AuthUser($entry->dn(), $pwd, $ldap);
		}
	}

	return 0;
}

1;
