#!/usr/bin/perl
foreach $f (`find * -type f -print`) {
    chomp ($f);
    ($f =~ /^bt/) && next;
    if (length($f) > 185) {
	printf "%3d %s\n", length($f), $f;
    }
}
