package Constants;
# The following Perl Modules are required:
#
# Crypt::CBC
# Crypt::Blowfish
# DBI
# DBD::mysql

use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(
        $PATH_DOCROOT $PATH_GOSH $GOSH_STORY $GOSH_ERROR $GOSH_SURVEY
        $GOSH_RESULTSURVEY $GOSH_SUCKITEM $GOSH_SUCKOLD $GOSH_LOGIN
        $GOSH_LOGGEDIN $GOSH_UPLOAD $GOSH_TRAILER $GOSH_USERMOD
        $GOSH_NEWSMOD

        $URL_HOME $URL_USERINFO

        $DB_HOST $DB_NAME $DB_USER $DB_PASS $DB_PORT $DB_DSN
        $DB_POSTDATE $DB_ARTICLETEXT $DB_USERID $NEWS_PER_PAGE

        $SURVEY_MAX $SURVEY_TALLY $COOKIE_SURVEY

        $SUCK_POPULAR $SUCK_RETIRE $SUCK_STAGNANT $COOKIE_SUCK

        $AUTH_LIFETIME $AUTH_COOKIE $AUTH_CRYPT $AUTH_KEY

	$LDAP_HOST $LDAP_USER $LDAP_PWD $LDAP_BASEDN

        @MONTHS
);

# =============================================================================
# File paths.
# =============================================================================
$PATH_DOCROOT = "/var/www";
$PATH_GOSH = "$PATH_DOCROOT/gosh";
$GOSH_STORY = "story.gosh";
$GOSH_ERROR = "error.gosh";
$GOSH_SURVEY = "survey.gosh";
$GOSH_RESULTSURVEY = "surveydone.gosh";
$GOSH_SUCKITEM = "suckitem.gosh";
$GOSH_SUCKOLD = "suckold.gosh";
$GOSH_LOGIN = "login.gosh";
$GOSH_LOGGEDIN = "loggedin.gosh";
$GOSH_UPLOAD = "upload.gosh";
$GOSH_TRAILER = "newstrailer.gosh";
$GOSH_USERMOD= "userinfo.gosh";
$GOSH_NEWSMOD = "newsedit.gosh";

$URL_HOME = "/~dave";
$URL_USERINFO = "$URL_HOME/userinfo.shtml";

# =============================================================================
# LDAP Constants
# =============================================================================
$LDAP_HOST = 'id.stahnkage.com';
$LDAP_BASEDN = 'dc=stahnkage,dc=com';
$LDAP_USER = "uid=loginadmin,ou=applications,$LDAP_BASEDN";
$LDAP_PWD = 'mobythecat';

# =============================================================================
# Database constants.
# =============================================================================
$DB_HOST = 'localhost';
$DB_NAME = 'suck';
$DB_USER = 'suck';
$DB_PASS = 'sucker';
$DB_PORT = '3306';
$DB_DSN = "DBI:mysql:database=$DB_NAME;host=$DB_HOST;port=$DB_PORT";

# ============================================================================= 
# Database column names.
# =============================================================================
$DB_POSTDATE = "Post_Date";
$DB_ARTICLETEXT = "Article";
$DB_USERID = "UID";

$NEWS_PER_PAGE = 3;

# ============================================================================= 
# Survey constants.
# ============================================================================= 
$SURVEY_MAX = 4;
$SURVEY_TALLY = $SURVEY_MAX + 1;
$COOKIE_SURVEY = 'S';

# =============================================================================
# Suck constants.
# =============================================================================
$SUCK_POPULAR = 20;
$SUCK_RETIRE = 125;
$SUCK_STAGNANT = 100;
$COOKIE_SUCK = 'K';

# =============================================================================
# Authentication information.  In order to change the cipher, you must also
# change the libary include in Security.pm in addition to $AUTH_CRYPT.
# =============================================================================
$AUTH_LIFETIME = 60 * 60 * 24 * 365;
$AUTH_COOKIE = 'RFDToken';
$AUTH_CRYPT = 'Twofish';
$AUTH_KEY = 'whatever';

@MONTHS = ( "", "January", "February", "March", "April", "May", "June",
	    "July", "August", "September", "October", "November", "December" );

1;
