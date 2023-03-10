#!/usr/bin/perl -w

while (@ARGV){
	$_=shift @ARGV;
	if ($_=~ /^-stp$/){$stp=shift @ARGV;}
	elsif ($_=~ /^-i$/){$input=shift @ARGV;}
	elsif($_=~ /^-o$/){$output=shift @ARGV;}
	elsif ($_=~ /^-snc$/){$snc=shift @ARGV;}
  elsif ($_=~ /^-tax$/){$tax=shift @ARGV;}
}
if (not defined ($stp)){print "\nThis script use several other scripts to extract information of gene function. The required arguments and inputs depend of the subscript you want to use.  To check the different subscript run the main script without arguments, if you want to check the arguments for one subscript just run the script with the specific subscript but without extra arguments (example MELFUnction.pl -stp BUSCO2GKO).\n\nUsage:\nMELFUntionannot\n\t-stp <You need determine what subscript you want to run>\n\t\tBUSCO2GKO\: <Extract gene ID from a busco code list and obtain the GO and KO terms>\n\n"; exit;}

use File::Basename;
use lib dirname (__FILE__) . "/MELFUnction";
use Cwd 'abs_path';
my $SCP1= abs_path($0);
$SCP1 =~ s/\.pl$/\//;
our $stprn =0;
our @stptr = split (/,/, $stp);
foreach $stp (@stptr){
	if ($stp eq "BUSCO2GKO"){
        	use BUSCO2GKO;
		if (not defined ($input)){print "\nThis script will extract the names of genes from busco codes and obtain the GO and KO terms for enrichment analyses. It requires a file with the list of codes one por row.\n\nUsage:\nBUSCO2GKO.pl\n\t-i <path to input list>\n\t-o <path to the output file, default GKO>\n Optional:\n\t-snc <number of runs in parallel, default 10>\n\t-tax <Taxon ID, sometimes the busco taxon ID is not recognized in other databases and you will have to change it, deafult the ID in the busco database you used>\n\t\n\nFor example:\nBUSCO2GKO -i /home/Yumafan/demultiplex/pamlgenes -o /home/Yumafan/nce -snc 10 -tax 9721\n\n"; exit;}
		if (not defined ($output)){$output="./GKO";}
		if (not defined ($snc)){$snc=10;}
		if (not defined ($tax)){
		our @arg = ("-i $input","-o $output","-snc $snc");
		}
		elsif (defined ($tax)){
		our @arg = ("-i $input","-o $output","-snc $snc","-tax $tax");
		}
	        BUSCO2GKO::getGKO(@arg);
        	$stprn = 0;
	}
#	elsif ($stp eq "demul"){
#		use dDocent;
#		if (not defined ($input && $barcode_file)){print "\nThis script uses stacks's process_rad to demultiplex fasta files.\n\nUsage:\nSNPcallPipe.pl -stp demul\n\t-i <directory with raw sequencing files>\n\t-o <output folder, if it does no exist it will be created>\n\t-bf <barcode file, tab delimited (LaneName SampleName Barcode Single Popnumber)>\nOptional:\n\t-lnc <number of lanes in parallel, or number of R1 files in you folder. default 1>\n\t-snc <number of samples perl lane in parallel, optimum 58/number of R1 files in you folder. default 10>\n\t-rad <RAD_tag, default TGCAGG TAA>\n\nFor example:\nSNPcallPipe.pl -stp demul -i /yuma/rawread/ -o /yuma/demultiplex -bf /yuma/barcodefile -lnc 1 -snc 10 \n\n"; exit;}
#		if (not defined $output){$output = "./demultiplex";}
#		if (not defined $lnc){$lnc=1;}
#		if (not defined $snc){$snc=10;}
#		our @arg = ("-i $input","-o $output","-bf $barcode_file","-lnc $lnc","-snc $snc", "-rad $radtag");
#		dDocent::demul(@arg);
#		$stprn = 1; 
#	}

}
