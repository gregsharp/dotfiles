#!/usr/bin/perl

use Cwd qw(abs_path);
use File::Spec::Functions qw(abs2rel canonpath catdir catfile);
use File::Copy::Recursive qw(dircopy);

#$basedir = "/dosf/play/mp3";
$basedir = "/home/gsharp/Music/mp3";
#$media_dir = "/media/SANSA FUZE/MUSIC";
$media_dir = "/media/gsharp/SANSA FUZE/MUSIC";
$num_copy = 10;

(-d $media_dir) || die "Can't open $media_dir";

@subdir_pats = 
  (
   "archive-pending/*/*",
   "boots-0*/*/*",
   "lossy-0*/*/*",
   "lossy-pending/*/*",
   "ripped/*/*",
   "studio-*/*/*",
   "wma-converted/*/*",
  );

@album_array = ();
use File::Glob ':globally';
for $subdir_pat (@subdir_pats) {
    $pat = catfile ($basedir, $subdir_pat);
    my @source_dirs = glob($pat);
    for $source_dir (@source_dirs) {
	# skip if not a directory
	-d $source_dir || next;

	# skip if no mp3 files in directory
	$have_mp3 = 0;
	opendir (my $dh, $source_dir);
	while (readdir $dh) {
	    if (/\.mp3/) {
		$have_mp3 = 1;
		last;
	    }
	}
	($have_mp3) || next;

	# add directory to copy list
	push (@album_array, $source_dir);
    }
}

print "Found $#album_array albums\n";

#print "$album_array[0]\n";
#print "$album_array[$#album_array-1]\n";
for $i (1..$num_copy) {
    $ri = int(rand($#album_array));
    $in_dir = $album_array[$ri];

    ## GCS FIX: Some directories don't have mp3s, need to detect this

    #print "$in_dir\n";
    $up_dir = abs_path (catdir ($in_dir, "../.."));
    $rel_path = abs2rel ($in_dir, $up_dir);
    $out_dir = catdir ($media_dir, $rel_path);
    #print "$out_dir\n";
    print "$rel_path\n";
    dircopy ($album_array[$ri], $out_dir);
}
