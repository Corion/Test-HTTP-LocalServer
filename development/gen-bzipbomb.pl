#!perl -w
use strict;
use warnings;
use IO::Compress::Bzip2 qw(bzip2 $Bzip2Error);

=head1 NAME

gen-bzipbomb.pl - generate a thrice-encoded bzip2 stream that decodes to 16MB

=cut

# Create a nasty bzip2 stream:
my $size = 16 * 1024 * 1024;
my $stream = "\0" x $size;

# Compress that stream three times:
my $compressed = $stream;
for( 1..3 ) {
    my $last = $compressed;
    bzip2(\$last, \$compressed)
        or die "Can't bzip2 content: $Bzip2Error";
    #diag sprintf "Encoded size %d bytes after round %d", length $compressed, $_;
};

use Data::Dumper;
$Data::Dumper::Useqq = 1;
print Dumper $compressed;
