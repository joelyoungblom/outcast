#!/usr/bin/perl -l 

# my $script_uri = "http://www.st-minutiae.com/resources/scripts/217.txt";
my $script_uri = "217.txt";

## initialize variables
my $role = ""; my @words = "";
my $total_lines = 0;
my %lines_per_role = ();
my $total_words = 0;
my %words_per_role = ();

## open file for reading
open( FILE_HANDLE, '<', $script_uri ) or die $!;
while( <FILE_HANDLE> ) {
  ## debug: print line read from file
  # print $_;

  ## if matches character name in dialog
  ## e.g.
  ## 					PICARD
  if( $_ =~ /^\t{5}([A-Z]+)\s*(\(.*\))?\s*$/ ) {
    # print "Matched " . $1; 
    $role = $1;
    ## read next lines and count lines for role
    while( <FILE_HANDLE> ) { 
      # print $_; 
      if( $_ =~ /^\s*$/ ) {
        # print "Ended match " . $1;
        last;
      } elsif( $_ =~ /^\s+(\(.*\))/ ) {
        ## parenthetical direction 
        next;
      } else {
        $lines_per_role{$role}++;
        $total_lines++;

        chomp( $_ );
        @words = split( / /, $_ );
        $words_per_role{$role} += @words;
        $total_words += @words;
      }
    }
  }
}
close( FILE_HANDLE );

print "Breakdown of lines and words per role:\n";
my $percent_lines; 
my $percent_words; 
printf( "%-8s %8s %8s %8s %8s\n", "ROLE", "LINES", "%", "WORDS", "%" );
print(  "============================================" );
foreach my $role (sort { $lines_per_role{$b} <=> $lines_per_role{$a} } keys %lines_per_role) {
  $percent_lines = $lines_per_role{$role} / $total_lines * 100;
  $percent_words = $words_per_role{$role} / $total_words * 100;
  printf( "%-8s %8s %8d %8s %8d\n", $role, $lines_per_role{$role}, $percent_lines, $words_per_role{$role}, $percent_words );
}
print(  "--------------------------------------------" );
printf( "%-8s %8s %17s\n", "TOTAL", $total_lines, $total_words );

exit 0;

