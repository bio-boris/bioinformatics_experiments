@ls = `ls`;

foreach my $ls(@ls){
    chomp $ls;
    if(not $ls =~ /pl/){
        system("qsub $ls");
    }

}
