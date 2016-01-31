#!/usr/bin/perl
use strict;
use warnings;


open(PRICES,'prices');
open(PRICESHTML,'>priceshtml');

print PRICESHTML '<table border="0" bordercolor="#FFCC00" width="530" cellpadding="3" cellspacing="3">' . "\n";

my $count = 0;
while(my $line = <PRICES>){
	chomp $line;
	if($count == 0){
		my @liner = split(/\t/,$line);
		print PRICESHTML "\t" . '<tr>' . "\n";
		print PRICESHTML "\t\t" . '<th align = left>' . $liner[0] . "\n";
		print PRICESHTML "\t\t" . '<th>' . $liner[1] . "\n";
		print PRICESHTML "\t\t" . '<th>' . $liner[2] . "\n";
		print PRICESHTML "\t" . "\n";
	}else{
		my @liner = split(/\t/,$line);
		print PRICESHTML "\t" . '<tr align = center>' . "\n";
		print PRICESHTML "\t\t" . '<td align = left>' . $liner[0]  . "\n";
		print PRICESHTML "\t\t" . '<td>&pound;' . $liner[1] . "\n";
		print PRICESHTML "\t\t" . '<td>&pound;' . $liner[2] . "\n";
		print PRICESHTML "\t" . "\n";
	}
	$count++;
}

print PRICESHTML '</table>';
