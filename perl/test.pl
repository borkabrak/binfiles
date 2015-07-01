use strict;
use warnings;

while(){
    print "Enter a pattern to match \n";
    #my $pattern = <STDIN>;
    my $pattern= $ARGV[0];
    chomp $pattern;
    print "\nEnter a word to match the pattern:";
    my $word = <>;
    chomp $word;

    if ($word =~ $pattern)
        {print "Matched: '$`'<'$&'>'$' \n";}
    elsif($word !~ $pattern)
        {print "No Match \n";}
}
