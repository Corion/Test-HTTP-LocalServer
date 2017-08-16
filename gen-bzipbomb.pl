use strict;
use warnings;

# Create a nasty bzip2 stream:
my $size = 16 * 1024 * 1024;
my $stream = "\0" x $size;

# Compress that stream three times:
my $compressed = $stream;
for( 1..3 ) {
    require IO::Compress::Bzip2;
    my $last = $compressed;
    IO::Compress::Bzip2::bzip2(\$last, \$compressed)
        or die "Can't bzip2 content: $IO::Compress::Bzip2::Bzip2Error";
    #diag sprintf "Encoded size %d bytes after round %d", length $compressed, $_;
};

use Data::Dumper;
$Data::Dumper::Useqq = 1;
print Dumper $compressed;