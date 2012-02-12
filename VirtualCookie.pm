package VirtualCookie;
# =============================================================================
# Virutal cookies are a fun and exciting way to get around the classic "my
# friends hate me so they shut off cookies and bombarded by survey tool"
# problem.  They are neither virtual nor cookies, but I came up with this
# fancy term for an IP log after I replaced all of my persistent cookies with
# these routines.
# =============================================================================
use Database;

use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(
	GetDateStamp
	ExpireVirtualCookies
	HasVirtualCookie
	SetVirtualCookie
);

# =============================================================================
sub GetDateStamp
# Return a YYYY-MM-DD datestamp.
# =============================================================================
{
	my @date = localtime;
	my $year = $date[5] + 1900;
	my $month = $date[4] + 1;
	my $day = $date[3];

	return sprintf("%4d-%02d-%02d", $year, $month, $day);
}

# =============================================================================
sub ExpireVirtualCookies
# Delete any obsoleted virtual cookies from the table.
# =============================================================================
{
	my ($dbh) = @_;

	my $datestamp = GetDateStamp();

	RunStatement("delete from iplog_t where Timestamp != '$datestamp'",
		$dbh);
}

# =============================================================================
sub HasVirtualCookie
# Determine if a user has a virtual cookie set for the given item/flag.
# =============================================================================
{
	my ($item, $flag, $dbh) = @_;

	my $datestamp = GetDateStamp();
	my $ip = $ENV{REMOTE_ADDR};

	ExpireVirtualCookies($dbh);

	my @results = RunQuery("select * from iplog_t where ip='$ip' and "
	                     . "disallow=$item and Timestamp='$datestamp' "
	                     . "and flag='$flag'", $dbh);

	return $#results + 1;
}

# =============================================================================
sub SetVirtualCookie
# Set a new virutal cookie for this user for the given item/flag.
# =============================================================================
{
	my ($item, $flag, $dbh) = @_;

	my $datestamp = GetDateStamp();
	my $ip = $ENV{REMOTE_ADDR};

	RunStatement("insert into iplog_t values($item, '$ip', '$datestamp', "
		   . "'$flag')", $dbh);

}

1;
