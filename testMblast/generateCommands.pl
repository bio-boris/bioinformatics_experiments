#!/usr/bin/env perl
# Generates blast, blast+ and mblast commands
use strict;
use warnings;
use File::Basename;
$\="\n";

my @blast_commands;
my @blast_plus_commands;
my @mblast_commands;

my $data_dir = `readlink -f ../data/fasta_databases`;

chomp $data_dir;

my @data_files = split /\n/, `ls $data_dir/blast | grep .fa\$`;

open SINGLE  , '>single.conf' or die $!;
open MULTIPLE, '>multiple.conf' or die $!;

foreach my $fasta(@data_files){
    print 
    blast($fasta);
}

sub blast{
    print $_;

    my $fasta = shift;
    my $input_fasta = "$data_dir/blast/$fasta";
    my $input_fasta_plus = "$data_dir/blast+/$fasta";
    my $name = (split /\//, $input_fasta)[-1];
    $name =~ s/\.fa//g;
    my $b = 3066502;
    my $cores = 24;



    #----------------------Blast---------------#
    my $blast_command = "blastall -p blastp -b $b -m8 -i $input_fasta -d $input_fasta -e 1e-5  ";
    my $outdir = `readlink -f blast `;
    chomp $outdir;
    mkdir("$outdir/exp1");
    mkdir("$outdir/exp2");

    my $single_command = "$blast_command -a1 -o $outdir/exp1/$name.exp1.blast"; 
    my $multi_command  = "$blast_command -a$cores -o $outdir/exp2/$name.exp2.blast";


    print SINGLE $single_command;
    print MULTIPLE $multi_command;
    
    push @blast_commands , $single_command, $multi_command;

    #--------------------------------------Blast+#
    
    my $blast_plus_command = "blastp -max_target_seqs $b -evalue 1e-5 -outfmt 6 -query $input_fasta_plus -db $input_fasta_plus";
    $outdir = `readlink -f blast+ `;
    chomp $outdir;
    mkdir("$outdir/exp1");
    mkdir("$outdir/exp2");

    $single_command     = "$blast_plus_command -num_threads 1 -out $outdir/exp/$name.exp1.blast+";
    $multi_command      = "$blast_plus_command -num_threads $cores -out $outdir/exp2/$name.exp2.blast+";
    
    print SINGLE $single_command;
    print MULTIPLE $multi_command;

    push @blast_plus_commands , $single_command, $multi_command;

    #--------------------------------------mblast

    my $mblast_command = "mblast max_target_seqs $b -evalue 1e-5 -db CL0023.fa";
    $outdir = `readlink -f mblast`;
    chomp $outdir;
    mkdir("$outdir/exp1");
    mkdir("$outdir/exp2");

    $single_command     = "$mblast_command -p 1  -o $outdir/exp1/$name.exp1.mblast+";
    $multi_command      = "$mblast_command -p $cores -o $outdir/exp2/$name.exp2.mblast+";
   

    print SINGLE $single_command;
    print MULTIPLE $multi_command;
    
    push @mblast_commands, $single_command, $multi_command;

}

print join "\n", @blast_commands,@blast_plus_commands,@mblast_commands;

