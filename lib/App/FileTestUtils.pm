package App::FileTestUtils;

use strict 'subs', 'vars';
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

use Getopt::Long qw(:config auto_help auto_version gnu_getopt no_ignore_case);

sub do_script {
    require File::MoreUtil;
    my ($func) = @_;

    (my $script = $func) =~ s/_/-/g;

    my $opt_grep_mode;
    my $opt_invert_match;
    GetOptions(
        "grep-mode|g" => \$opt_grep_mode,
        "invert-match|v" => \$opt_invert_match,
    ) or die "$script: Error in processing command-line options, exiting\n";

    if ($opt_grep_mode) {
        my @files = @ARGV;
        unless (@files) { chomp(@files = <STDIN>) }
        for my $file (@files) {
            if (&{"File::MoreUtil::$func"}($file) xor $opt_invert_match) { print $file, "\n" }
        }
        exit 0;
    } else {
        unless (@ARGV == 1) {
            die "Usage: $script <path>\n";
        }
        exit(&{"File::MoreUtil::$func"}($ARGV[0]) ? 0:1);
    }
}

1;
#ABSTRACT: More CLIs for file testing

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

This distributions provides the following command-line utilities which are
related to file testing:

# INSERT_EXECS_LIST


=head1 SEE ALSO

The file testing operators in L<perlfunc>, e.g. C<-s>, C<-x>, C<-r>, etc.

L<File::MoreUtil>

=cut
