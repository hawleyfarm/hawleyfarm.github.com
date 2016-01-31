#!/usr/bin/perl
use strict;
use warnings;

open(SOURCE,"sourcehtml");
my %insert;
my %nosecondlevels;
my $currentfirstlevel;
my $currentsecondlevel;
my @levelones;
my @leveltwos;
while(my $line = <SOURCE>){
    if($line =~ m/^[\*]([A-Z].*)/){
	$currentfirstlevel = $1;
	push(@levelones,$1);
	$currentsecondlevel = "none";
	$insert{$currentfirstlevel}{$currentsecondlevel} = "";
	$nosecondlevels{$currentfirstlevel} = 0;
    }elsif($line =~ m/^[\*][\*]([A-Z].*)/){
	$currentsecondlevel = $1;
	push(@leveltwos,$1);
	$insert{$currentfirstlevel}{$currentsecondlevel} = "";
	$nosecondlevels{$currentfirstlevel}++;
    }else{
	$insert{$currentfirstlevel}{$currentsecondlevel} = $insert{$currentfirstlevel}{$currentsecondlevel} . $line;
    }
}
close(SOURCE);

open(SOURCE,"righthtml");
my %right;
while(my $line = <SOURCE>){
    if($line =~ m/^[\*]([A-Z].*)/){
	$currentfirstlevel = $1;
	$currentsecondlevel = "none";
	$right{$currentfirstlevel}{$currentsecondlevel} = "";
    }elsif($line =~ m/^[\*][\*]([A-Z].*)/){
	$currentsecondlevel = $1;
	$right{$currentfirstlevel}{$currentsecondlevel} = "";
    }else{
	$right{$currentfirstlevel}{$currentsecondlevel} = $right{$currentfirstlevel}{$currentsecondlevel} . $line;
    }
}
close(SOURCE);

my $leveltwocount = 0;

open(TEMPLATE,"template.html");
my @template = <TEMPLATE>;
my $space = "\&nbsp\; \&nbsp\; \&nbsp\; \&nbsp\; ";

open(OSMAP,"osmaphtml");
my $osmap = "";
while(my $line = <OSMAP>){
	$osmap = $osmap . $line;
}

foreach my $levelone (@levelones){
    my @currentleveltwos = ("none");
    if($nosecondlevels{$levelone} > 0){
	for(my $counter = $leveltwocount;$counter < ($leveltwocount + $nosecondlevels{$levelone});$counter++){
	    push(@currentleveltwos,$leveltwos[$counter]);
	}
	$leveltwocount = $leveltwocount + $nosecondlevels{$levelone};
    }
    foreach my $leveltwo (@currentleveltwos){
	print "$levelone\t$leveltwo\n";
	my $filename = $levelone;
	if($leveltwo ne "none"){
	    $filename = $filename . $leveltwo;
	}
	$filename =~ s/ //g;
	$filename =~ s/&//g;
	open(OUTPUT,">$filename.html");
	foreach my $line (@template){
	    if($line =~ m/OSMAP/){
		if($filename =~ m/Location/){
		    print OUTPUT $osmap;
		}
	    }elsif(($line =~ m/\<body\>/) && ($filename =~ m/Location/)){
		print OUTPUT '<body onload="initmapbuilder()">' . "\n";
	    }elsif($line =~ m/TITLETITLE/ && $leveltwo eq "none"){
		print OUTPUT $levelone;
	    }elsif($line =~ m/TITLETITLE/){
		print OUTPUT $leveltwo;
	    }elsif($line =~ m/NAVIGATIONNAVIGATION/){
		foreach my $liner (@levelones){
		    if($liner eq $levelone && $leveltwo eq "none"){
			print OUTPUT "<h3>$levelone \<\<\/h3>\n";
			foreach my $ltwo (@currentleveltwos){
			    if($ltwo ne "none"){
				my $filenamer = $liner . $ltwo;
				$filenamer =~ s/ //g;
				$filenamer =~ s/&//g;
				print OUTPUT "<h4><a href=\"$filenamer.html\">$space$ltwo\<\/a><\/h4>\n";
			    }
			}
		    }elsif($liner eq $levelone && $leveltwo ne "none"){
			my $filenamer = $liner;
			$filenamer =~ s/ //g;
			$filenamer =~ s/&//g;
			print OUTPUT "<h2><a href=\"$filenamer.html\">$liner\<\/a><\/h2>\n";
			foreach my $ltwo (@currentleveltwos){
			    if($ltwo ne "none"){
				if($ltwo ne $leveltwo){
				    my $filenamer = $liner . $ltwo;
				    $filenamer =~ s/ //g;
				    $filenamer =~ s/&//g;
				    print OUTPUT "<h4><a href=\"$filenamer.html\">$space$ltwo\<\/a><\/h4>\n";
				}else{
				    print OUTPUT "<h4>$space$ltwo \<\<\/h4>\n";
				}
			    }
			}
		    }else{
			my $filenamer = $liner;
			$filenamer =~ s/ //g;
			$filenamer =~ s/&//g;
			print OUTPUT "<h2><a href=\"$filenamer.html\">$liner\<\/a><\/h2>\n";
		    }
		}
	    }elsif($line =~ m/HTMLHTML/){
		print OUTPUT $insert{$levelone}{$leveltwo};
	    }elsif($line =~ m/RIGHTRIGHT/){
		print OUTPUT $right{$levelone}{$leveltwo};
	    }else{
		print OUTPUT $line;
	    }
	}
    }
}

my $marquee = q(
<marquee behavior="scroll" direction="up" scrollamount="1.5" height="190" width="180">
Our holiday experience totally exceeded our expectations! We found (at last) our perfect UK holiday. The Barn was beautifully appointed and felt like home instantly, the level of attention to detail, fit, finish and comfort was first class nothing could be faulted. The atmosphere was relaxed, comfortable and very tranquil. Pamela, Graham and the boys really made the holiday for us as they are so frendly and helpful and it was a wonderful experience to see the milking and the calves being fed. We bought our mountain bikes with us and there are loads of rides starting at the farm and very little traffic. East Devon has wonderful countryside and we will be back soon! Jeremy, Sarah & Jack from Falmouth, Cornwall
<br><br>
Thanks very much for a great week in the Wagon House - it was a lovely location and we all very much enjoyed our break! Thank you Graham for the tour around the farm - it was very interesting and it was nice for me as a Cornish man to see cows, hedges and grass instead of flat fields of wheat!! Laura and I would love to come down and stay again at some point soon as there was much that we did not have time for! It would also be a good location to meet up with my Mum & Dad instead of having a 6hr drive back to Lands End !! Thanks again Oscar & Loura, Cambridge 
<br><br>
We had a wonderful holiday in the Cider Press. It is very well equipped with everything you could need as well as being very comfortable. It is in a beautiful position on the farm with lots of lovely walks all around. Graham and Pamela could not have made us feel more welcome and we really enjoyed looking around the farm. We all agreed we'd love to go again because we felt so much at home and there are still plenty of places to explore. We were proud to be the first people to stay in the WAGEN HOUSE!! 
<br><br>
Wow what a house, What nice people Pamela & Graham are. We had a fab time we were really made to feel at home and all your did for us and the girls, the milking, tractor rides and of course the best little sweet dog TAIMAR which the girls still speak about, we loved your place and every thing about it. Thanks so much and wish much luck and success in your holiday homes. With best wishers Anthony, Sara Rikki & Penina ( Manchester) Aug 2010.
<br><br>
10th October 2010 - Our stay at the Wagon House was fantastic. A perfect, tranquil setting. The place certainly has the WOW factor. Well equipped, everything you could possibly need and we didn't want to leave. An ideal place for touring not only East Devon but also the beautiful Dorset coast. Will certainly return.
<br><br>
Fantastic!!!!!!!!! Ian C
<br><br>
We had a fantastic family holiday here - Graham and Pamela were great hosts and went out of their way to let us experience farm life first hand. Wherever we went our girls insisted that we had to be back in time to feed the calves! We stayed in the Cider Press and it was lovely - a very comfortable home from home with everything we could possibly want. None of us wanted to leave when the time came and we will definitely be back next year to see how the calves that were born during our stay are progressing.
<br><br>
staying at The Cider Press on Hawley Farm was like staying in a 5 star hotel.Pam and Graham have put alot more than just hard work into making The Cider Press what it is today. We have stayed at many properties in Devon over many years and this property tops them all. The children had great fun in going in the land rover over to milk the cows, not something children from Reigate do or see everyday.We wish you both good luck and have already told many friends that we had a wonderful time at Hawley Farm with the children not wanting to leave.keep doing what you have done, it works !
</marquee>
);

open(HOME,"Home.html");
my @home = <HOME>;
close(HOME);

open(HOME,">Home.html");
foreach my $line (@home){
	if(grep(/h2axemouthharbour/,$line)){
		print HOME $marquee . "\n";
	}elsif(grep(/lymeregisbeach/,$line)){
	}else{
		print HOME $line;
	}
}
close(HOME);


system("cp Home.html index.html");
