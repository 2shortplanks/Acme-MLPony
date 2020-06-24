package Acme::MLPony::Util;

use base qw(Exporter);
our @EXPORT_OK = qw( pony unpony );

my @PONIES = split /\n/, <<PONIES;
Ahuizotl
Apple Bloom
Apple Rose
Applejack
Auntie Applesauce
Babs Seed
Barley Barrel
Big McIntosh
Braeburn
Bulk Biceps
Capper
Captain Celaeno
Chancellor Neighsay
Chancellor Puddinghead
Cheerilee
Chrysalis
Cloudy Quartz
Clover the Clever
Coco Pommel
Commander Hurricane
Cozy Glow
Cranky Doodle
Daring Do
Diamond Tiara
Discord
Dragon Lord Ember
Fancy Pants
Flam
Flash Magnus
Flim
Flurry Heart
Fluttershy
Gabby
Gallus
Garble
General Seaspray
Gilda
Goldie Delicious
Grampa Gruff
Grand Pear
Granny Smith
Grogar
Grubber
Hayseed Turnip Truck
Hoity Toity
Hoops
Igneous Rock
Kerfuffle
King Sombra
Lemon Hearts
Limestone Pie
Lord Tirek
Lyra Heartstrings
Mage Meadowbrook
Marble Pie
Matilda
Maud Pie
Mayor Mare
Minuette
Mistmane
Moody Root
Mr. Carrot Cake
Mr. Hoofington
Mrs. Cup Cake
Mrs. Hoofington
Muffins
Ocean Flow
Ocellus
Octavia Melody
Petunia Petals
Photo Finish
Pickle Barrel
Pinkie Pie
Pipsqueak
Pound
Prince Blueblood
Prince Rutherford
Princess Cadance
Princess Celestia
Princess Luna
Princess Platinum
Princess Skystar
Private Pansy
Pumpkin
Queen Chrysalis
Queen Novo
Rainbow Dash
Rarity
Rockhoof
Sandbar
Sapphire Shores
Sassy Saddles
Scootaloo
Shining Armor
Silver Spoon
Silverstream
Sky Beak
Smart Cookie
Smolder
Snails
Snips
Somnambula
Songbird Serenade
Spike
Spitfire
Star Swirl the Bearded
Starlight Glimmer
Stygian
Sugar Belle
Sunburst
Sunny Skies
Suri Polomare
Sweetie Belle
Sweetie Drops
Tempest Shadow
Terramar
The Storm King
Thorax
Time Turner
Torch
Torque Wrench
Trixie Lulamoon
Twilight Sparkle
Twinkleshine
Uncle Orange
Vinyl Scratch
Yona
Zecora
PONIES

my %PONIES = map { $PONIES[ $_ ] => $_ } (0..($#PONIES-1));

sub pony {
    my $result = join ', ', 
        # get the pony per half byte
        map { $PONIES[ $_ ] }

        # split the byte in half: turn this into two numbers between 0 and 127
        map { ($_ & 0b11110000) >> 4, ($_ & 0b00001111) }

        # turn into the code for that byte
        map { ord $_ }

        # split by bytes
        split //, shift;

    # turn into lines of no more than 72 chars
    $result =~ s{
        (?=.{72,})       # when there's more than 72 characters left
        (.{0,70})        # get up to 70 characters
        (?:,[ ])         # followed by a comma and a space
    }{$1,\n}gx; 

    return $result . "\n";
}

sub unpony {
    # remove leading and trailing whitespace
    my $src = shift;
    $src =~ s/^\s+//;
    $src =~ s/\s+$//;

    # get the two half bytes per pony name
    my @data = map { $PONIES{ $_ } } split /,\s+/, $src;

    # process the half bytes two at a time and turn them back into bytes
    my $result = "";
    while (@data) {
        $result .= chr( (shift(@data) << 4) | shift(@data) );
    }
    return $result;
}


1;