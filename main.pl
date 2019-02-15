use strict;
use warnings;

sub saveFile {
	my $fileName = $_[0];
	open my $tmp, ">", $fileName;
	print $tmp $_[1];
	close $fileName;
}

opendir my $dir, "." or die "Cannot open directory: $!";
my @files = readdir $dir;
closedir $dir;
my @perlFiles = grep /.pl$/, @files;
my $realContent;

for my $currentFile (@perlFiles) {
	open my $content, "<", $currentFile;
	close $currentFile;
	print "current file is $currentFile\n";
	local $/;
	$realContent = <$content>;	

	if ($realContent !~ /use strict;/) {
		print "Has no use strict, adding use strict to the file...\n";
			saveFile($currentFile . ".backup", $realContent);
		if ($realContent =~ s/(?<=use \w;\n)(use \w+;\n)(?!use \w+;)/$1use strict;\n/) {
			saveFile($currentFile, $realContent);
		 }
	} else { 
		print "Has use strict, skipping...\n";
	}
}
