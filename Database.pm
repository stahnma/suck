package Database;

use DBI;
use DBD::mysql;
use Constants;
use Prettify;

use Exporter ();
@ISA = qw(Exporter);
@EXPORT = qw(
	GetHandle CloseHandle
	RunQuery RunStatement
	GetNewestPostID
	GetDBDate
);

#==============================================================================
sub GetHandle
# Returns a new database handle.  Does not perform any error checking.
# =============================================================================
{
	my $dbh = DBI->connect($DB_DSN, $DB_USER, $DB_PASS,
		{ 'RaiseError' => 1,
		  'PrintError' => 0 } );
	return $dbh;
}

# =============================================================================
sub CloseHandle
# Close a database handle.
# =============================================================================
{
	my ($dbh) = @_;

	$dbh->disconnect();
}

# =============================================================================
sub RunQuery
# Executes a new query.  If a database handle is available, it is used.
# =============================================================================
{
	my ($query, $dbh) = @_;
        my @results = ();

	if (!$dbh)
	{
		$dbh = GetHandle();
	}

	if (!$dbh)
	{
		RaiseError("Could not connect to $DB_DSN.");
	}

	my $sth = $dbh->prepare($query);
	eval { $sth->execute() };

	if($@)
	{
		RaiseError("Failed to execute query '$query' ($@).");
	}

	while (my $ref = $sth->fetchrow_hashref())
	{
		push @results, $ref;
	}
	$sth->finish();

	return @results;
}

# =============================================================================
sub RunStatement
# Executes a new statement.  If a database handle is available, it is used. 
# =============================================================================
{
	my ($stmt, $dbh) = @_;
	
	if (!$dbh)
	{
		$dbh = GetHandle();
	}

	if (!$dbh)
	{
		RaiseError("Could not connect to $DB_DSN.");
	}

	eval { $dbh->do($stmt) };

	if ($@)
	{
		RaiseError("Failed to execute statement '$stmt' ($@).");
	}
}

# =============================================================================
sub GetNewestPostID
# Return the ID of the newest post.
# =============================================================================
{
	my ($dbh) = @_;

	my @results = RunQuery("select max(Post_ID) MAXX from news_t");
	return $results[0]->{MAXX};
}

# =============================================================================
sub GetDBDate 
# Make a database formatted date.
# =============================================================================
{
	my ($ts) = @_;

	if (!$ts)
	{
		$ts = time;
	}

	my ($sec,$min,$hour,$mday,$mon,$year,$wd,$yd,$dst) = localtime($ts);

	return sprintf("%04d-%02d-%02d", $year + 1900, $mon + 1, $mday);
}

1;
