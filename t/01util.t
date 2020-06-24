#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

use Acme::MLPony::Util qw( pony unpony );

my $string = "This is an example string";
my $pony   = pony($string);
my $unpony = unpony($pony);

is ($string, $unpony, "round trip");
is ($pony, <<'STRING', "pony form");
Babs Seed, Auntie Applesauce, Barley Barrel, Braeburn, Barley Barrel,
Bulk Biceps, Big McIntosh, Applejack, Apple Rose, Ahuizotl,
Barley Barrel, Bulk Biceps, Big McIntosh, Applejack, Apple Rose,
Ahuizotl, Barley Barrel, Apple Bloom, Barley Barrel, Cheerilee,
Apple Rose, Ahuizotl, Barley Barrel, Babs Seed, Big McIntosh, Braeburn,
Barley Barrel, Apple Bloom, Barley Barrel, Chancellor Puddinghead,
Big McIntosh, Ahuizotl, Barley Barrel, Chancellor Neighsay,
Barley Barrel, Babs Seed, Apple Rose, Ahuizotl, Big McIntosh,
Applejack, Big McIntosh, Auntie Applesauce, Big McIntosh, Apple Rose,
Barley Barrel, Bulk Biceps, Barley Barrel, Cheerilee, Barley Barrel,
Big McIntosh
STRING