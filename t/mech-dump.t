use warnings;
use strict;
use Test::More;
use File::Spec;
use URI::file;

local $/ = undef;

my $exe = File::Spec->catfile( qw( blib script mech-dump ) );
plan skip_all => "Not installing mech-dump" if -e "t/SKIP-MECH-DUMP";
plan tests=>1;

my $data = File::Spec->catfile( qw( t google.html ) );
my $actual = `$exe --forms $data`;

my $target = URI->new_abs( "/target-page", $data );
$target = URI::file->new_abs( $target )->as_string;

my $expected = <DATA>;
$expected =~ s/#TARGET#/$target/;
is( $actual, $expected, "Matched expected output" );

__DATA__
GET #TARGET#
  hl=en                           (hidden)  
  ie=ISO-8859-1                   (hidden)  
  q=
  btnG=Google Search              (submit)  
  btnI=I'm Feeling Lucky          (submit)  
