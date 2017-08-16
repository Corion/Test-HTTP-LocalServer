use strict;
use warnings;

# Create a nasty gzip stream:
my $size = 16 * 1024 * 1024;
my $stream = "\0" x $size;

# Compress that stream three times:
my $compressed = $stream;
for( 1..3 ) {
    require IO::Compress::Gzip;
    my $last = $compressed;
    IO::Compress::Gzip::gzip(\$last, \$compressed, Level => 9, -Minimal => 1)
        or die "Can't gzip content: $IO::Compress::Gzip::GzipError";
    #diag sprintf "Encoded size %d bytes after round %d", length $compressed, $_;
};

use Data::Dumper;
$Data::Dumper::Useqq = 1;
print Dumper $compressed;