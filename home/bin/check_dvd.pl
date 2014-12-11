#!/usr/bin/perl
use Cwd;
use File::Spec::Functions qw(catfile);
use Time::HiRes;

$dvd = "/mnt/dvd";
@ref_dirs = (
    "/scratch1/archive",
    "/home/gsharp/flac",
    "/mnt/ehd1/archive",
    );
$dvd_cache = "/tmp/gcs_dvd_cache.txt";
$ref_cache = "/tmp/gcs_ref_cache.txt";

#########################################################################
# This subroutine reads a file into a string
#########################################################################
sub slurp ($) {
    my ($filename) = @_;
    open my $fh, '<', $filename or die "error opening $filename: $!";
    my $text = do { local $/; <$fh> };
    close $fh;
    return $text;
}

#########################################################################
# This subroutine computes the md5sum of files in a directory
#########################################################################
sub md5dir ($) {
    my ($dirname) = @_;
    my $cwd = getcwd;
    chdir "$dirname";
    $text = `find * -type f -exec md5sum {} \\;`;
    chdir $cwd;
    return $text;
}

#########################################################################
# This subroutine saves the text to a cache file
#########################################################################
sub cache_save ($$) {
    my ($fn, $text) = @_;
    open my $fh, '>', $fn or die "error opening cache: $!";
    print $fh $text;
    close $fh;
}

#########################################################################
# This subroutine returns a string with the directory listing
#########################################################################
sub list_dir ($) {
    my ($somedir) = @_;
    opendir (my $dh, $somedir) || die "can't opendir $somedir: $!";
    @files = grep { (!/^\./) } readdir ($dh);
    closedir $dh;
    return join (' ', sort @files);
}

#########################################################################
# MAIN
#########################################################################

$force = 0;
$print_usage = 1;
if ($#ARGV == 0) {
    $series = "$ARGV[0]";
    $print_usage = 0;
}
if ($#ARGV == 1) {
    if ("$ARGV[0]" eq "-f") {
	$force = 1;
	$series = "$ARGV[1]";
	$print_usage = 0;
    }
}

if ($print_usage) {
    die "Usage: check_dvd.pl [-f] series\n";
}

# Find reference and dvd diretories
for $ref (@ref_dirs) {
    $ref_dir = catfile ($ref, $series);
    last if (-d $ref_dir);
}
if (! -d $ref_dir) {
    die "Can't find reference directory: $ref_dir";
}
$dvd_dir = catfile ($dvd, $series);
if (! -d $dvd_dir) {
    $dvd_dir = $dvd;
}
# Special hacks for older dvds: "data-01" through "data-04"
($series eq "data-01") and $dvd_dir = catfile ($dvd_dir, "data");
($series eq "data-02") and $dvd_dir = catfile ($dvd_dir, "data-2");
($series eq "data-03") and $dvd_dir = catfile ($dvd_dir, "data-3");
($series eq "data-04") and $dvd_dir = catfile ($dvd_dir, "data-4");
if (! -d $dvd_dir) {
    die "Can't find reference directory: $dvd_dir";
}

print "REF dir = $ref_dir\n";
print "DVD dir = $dvd_dir\n";

# Do quick check, make sure user didn't specify wrong series
$ref_list = &list_dir ($ref_dir);
$dvd_list = &list_dir ($dvd_dir);
if ($ref_list ne $dvd_list) {
    print "** Warning ** directory listings do not match.\n";
    print "REF: $ref_list\n";
    print "DVD: $dvd_list\n";
}

# Check for md5sums.txt
$md5sum_file = catfile ($dvd_dir, "md5sums.txt");
if (! -f $md5sum_file) {
    $md5sum_file = catfile ($dvd_dir, "checksum.md5");
}
if (! -f $md5sum_file) {
    $md5sum_file = catfile ($ref_dir, "md5sums.txt");
}
if (! -f $md5sum_file) {
    $md5sum_file = catfile ($ref_dir, "checksum.md5");
}

my $ref_text;
if (!$force && -f $md5sum_file) {
    # Read reference values for md5 sums
    print "Reading MD5 sum file: $md5sum_file\n";
    $ref_text = &slurp ($md5sum_file);
}
else {
    # Compute reference values for md5 sums
    print "Computing MD5 sums in directory: $ref_dir\n";
    $start = Time::HiRes::gettimeofday();
    $ref_text = &md5dir ($ref_dir);
    $end = Time::HiRes::gettimeofday();
    printf "Time elapsed: %.2f sec\n", $end - $start;
    print "Caching computed md5 sums\n";
    cache_save ($ref_cache, $ref_text);
    #$ref_text = &slurp ($ref_cache);
}

# Compute md5 sum values on dvd
print "Computing MD5 sums in directory: $dvd_dir\n";
$start = Time::HiRes::gettimeofday();
my $dvd_text = &md5dir ($dvd_dir);
$end = Time::HiRes::gettimeofday();
printf "Time elapsed: %.2f sec\n", $end - $start;
print "Caching computed md5 sums\n";
cache_save ($dvd_cache, $dvd_text);
#my $dvd_text = &slurp ($dvd_cache);

# Store reference values into hash
for (split /^/, $ref_text) {
    chomp;
    ($hash, $fn) = split(' ', $_, 2);
    $fn =~ s/^\.\///;
    #print "$hash || $fn\n";
    $ref_hash{$fn} = $hash;
}

# Store dvd values into hash
for (split /^/, $dvd_text) {
    chomp;
    ($hash, $fn) = split(' ', $_, 2);
    $fn =~ s/^\.\///;
    #print "$hash || $fn\n";
    $dvd_hash{$fn} = $hash;
}

my $matches = 0;
my $failures = 0;

# Lookup ref values in dvd hash
for (split /^/, $ref_text) {
    chomp;
    ($hash, $fn) = split(' ', $_, 2);
    $fn =~ s/^\.\///;
    if ($val = $ref_hash{$fn}) {
	# Do nothing, error printed below
    } else {
	$failures ++;
	print "No hash in dvd found for $fn\n";
    }
}

# Lookup dvd values in ref hash
for (split /^/, $dvd_text) {
    chomp;
    ($hash, $fn) = split(' ', $_, 2);
    $fn =~ s/^\.\///;
    if ($val = $ref_hash{$fn}) {
	if ($val != $hash) {
	    $failures ++;
	    print "Hash mis-match for $fn\n";
	} else {
	    $matches ++;
	    #print "Match: $val, $hash\n";
	}
    } else {
	# Don't count missing entry of checksum file as a failure
	if ($fn ne "checksum.md5") {
	    $failures ++;
	    print "No hash found in ref for $fn\n";
	}
    }
}

print "Matched files: $matches\n";
print "Failed files: $failures\n";
