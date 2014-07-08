@ls = `ls`;

my $arg = shift @ARGV;



foreach my $ls(@ls){
    chomp $ls;
    if(not $ls =~ /pl/){
        system("qsub $ls");
    }

}
