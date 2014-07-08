#!/usr/bin/env perl
use strict;

chdir("/home/n-z/sadkhin2/testclan23/blast+");
print `pwd`;
my $experiment = "experiment" . $ARGV[0];

my $filename = "CL0023.fa_0";

print "$ARGV[0]\n";
if($ARGV[0] > 4){
    $filename = "CL0023.fa_24123";
}

my $cores = $ARGV[1];


my $command = "blastp -query $filename  -max_target_seqs 3066502 -evalue 1e-6 -outfmt 6 -db CL0023.fa ";

$command .=" -out $experiment/$experiment.blast ";

if(length $cores > 0){
    $command .= "-num_threads $cores";
}

mkdir($experiment);
print $command,"\n";
system($command);



