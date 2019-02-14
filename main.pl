
use warnings;

opendir my $dir, "." or die "Cannot open directory: $!";
my @files = readdir $dir;
closedir $dir;
my @perlFiles = grep /.pl$/, @files;

my $realContent;

for my $currentFile (@perlFiles) {
	open my $content, "<", $currentFile;

	local $/;
	$realContent = <$content>;

	close $currentFile;
}

if ($realContent =~ /use strict;/) {
	print "MATCHED";
}
$realContent =~ s/grep/GREB/;
#print $realContent;
