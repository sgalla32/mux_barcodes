#!/usr/bin/perl

my $usage = "mux_barcodes file_with_barcodes directory_with_fastq\n";

unless ($#ARGV == 1) {
    die $usage;}

open (READ, $ARGV[0]);
while (<READ>){
    chomp;
    push (@barcodes, $_);
}
close READ;

opendir DIR, $ARGV[1];
my @files = readdir DIR;
closedir DIR;

my @keyfile;

my $barcode_counter = -1;
foreach my $n (@files) {
    if ($n =~ /\.fastq$/) {
        $barcode_counter++;
	$outfile = $n;
	$outfile =~ s/fastq$/barcoded.fastq/;
	open (READ, $n);
	open (WRITE, ">$outfile");
	while (<READ>) {
	    print WRITE $_;
	    my $i = <READ>;
	    print WRITE $barcodes[$barcode_counter];
	    print WRITE $i;
	    $i = <READ>;
	    print WRITE $i;
	    $i = <READ>;
	    print WRITE ("F" x length($barcodes[$barcode_counter])), $i;
	}
	close READ;
	close WRITE;
	push (@keyfile, "$barcodes[$barcode_counter]\t$outfile\n");
    }
}

open (WRITE, ">keyfile.barcoded.txt");
print WRITE @keyfile;
close WRITE;
