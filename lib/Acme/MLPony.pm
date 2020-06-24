package Acme::MLPony;

use strict;
use warnings;

use base qw(Exporter);
use Fatal qw(open close);

use Acme::MLPony::Util qw( pony );

our @EXPORT_OK = qw( pony_file );

sub pony_file {
    my $filename = shift;

    # read in the entire of the file
    open my $in, "<:bytes", $filename;
    my $data = do { local $/; <$in> };
    close $in;

    my $shebang;
    if ($data =~ s/^(#!.*)//) {
        $shebang = $1;
    }

    # write it out again
    open my $out, ">:bytes", $filename;
    print $out $shebang, "\n" if $shebang;
    print $out "use Acme::MLPony::Friendship;\n";
    print $out pony($data);
    close $out;
}

1;