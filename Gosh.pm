package Gosh;
# =============================================================================
# A gosh file is an HTML file with "gosh" tags inserted into it.  A Gosh tag
# is simply a variable name surrounded by backslashes (like \var1\ \var2\).
# A lot of the HTML output that the scripts use is done into a gosh so that we
# don't have ugly HTML messing up our pretty code.  This package contains the
# subroutines needed to output to a gosh.
# =============================================================================
use Constants;
use Prettify;

use Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(WriteGosh);


# =============================================================================
sub WriteGosh
# Output data to a gosh file.  We assume the file is in the gosh path.
# =============================================================================
{
	my ($file, %xref) = @_;
	my $openfile = "$PATH_GOSH/$file";

	if (!-e $openfile || -d $openfile)
	{
		Prettify::RaiseError("$openfile does not exist.");
	}

	Prettify::PrintHeader();
	open IN, "$PATH_GOSH/$file";
	while (<IN>)
	{
		s/\\(.+?)\\/$xref{$1}/g;
		print;
	}
	close IN;
}

1;
