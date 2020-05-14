#!/usr/bin/perl
# VPN DoS result formatter 
# by TZ 
#
# Changelog
# 1.0 - Initial version

use strict;
use warnings;
use Getopt::Long;
use File::Basename;

my $basename = basename($0);

# usage information 
sub show_help {
	print <<HELP;
VPN DoS Result Formatter - by TZ 

Usage: ./$basename <dos log file>

Example: ./$basename dos-check.ts
	
HELP
	exit 1;
}

# declare variables
my $help = 0;

GetOptions(
	'h'	  => \$help,
) or show_help;

$help and show_help;

my $file = $ARGV[0];
!defined($file) and show_help;

# before filter
sub start {
	open (FILE, $file) or die "Cannot open ".$file.": ".$!;
	search();
	close (FILE);
}

my $percent = 0;

# format the result
sub search {
	while(<FILE>) {
	
		if (/Ending ike-scan \d\.\d\.\d\: (\d+) hosts scanned in \d+\.\d+ seconds \((\d+.\d+) hosts\/sec\)\.  (\d+) returned handshake; \d+ returned notify/) {
			$percent = ($3/$1)*100;
			print $1 . "\t" . $3 . "\t" . $2 . "\t" . $percent . "%\n";
		}
	}
}

start();
