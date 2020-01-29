#!/usr/bin/perl -w 
use warnings;
use strict;

my $filename = "271.txt";
open(FILE_HANDLE, '<', $filename) or die $!;

my %characters_lines = ();
my $max = 50; my $count = 0;
while( <FILE_HANDLE> ) {
  $count++ < $max ? print $_ : exit 0;
   
}
close(FILE_HANDLE); 



exit 0;

