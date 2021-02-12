#!/usr/bin/perl

#use strict;
#use warnings;
#use autodie;
#use utf8;


open $FH, " | dmenu -i -l 30 -fn '-xos4-terminus-medium-r-*-*-10-*' | sed 's/^\\(.\\).*/\\1/' | tr -d '\n' | { xsel -ib; xsel -ip; } ";

# if you do not have the xos4-terminus font that makes characters a little bigger :
# uncoment this line and use the second here document
#open $FH, " | dmenu -i -l 30 | sed 's/^\\(.\\).*/\\1/' | tr -d '\n' | { xsel -ib; xsel -ip; } ";

# also you can compile dmenu from source and change the font size directly in the C done
# in the file config.h / config.def.h

# this heredoc is well aligned with the -xos4-terminus-medium-r-*-*-10-* font

print $FH <<'EOF'
«         hyper operator
»         hyper operator
∈        membership
∉        non-membership
∪         set union
∩         set intersection
∖         set difference
≡         set equality
≢        set inequality
⊖        symmetric set difference
⊍         baggy multiplication
⊎         baggy addition
∅        empty set
⊆        subset
⊈         not a subset
⊂        strict subset
⊄        not a strict subset
∋        reverse membership
∌          reverse non-membership
⊇        superset
⊉         not a superset
⊃        strict superset
⊅        not a strict superset
∞         infinity
⚛        atomic operator
π        pi
τ         tau
𝑒         Euler's number
∘         function composition
×        multiplication 
÷        division
≤         inferior or equal
≥         greater or equal
≠   	     inequality
−        substraction
≅       approximatively equal
…      sequence operator
‘         left single quotation mark
’         right single quotation mark
‚         single low-9 quotation mark 
”         right double quotation mark
“         left double quotation mark
„         double low-9 quotation mark
｢         halfwidth left corner bracket
｣         halfwidth right corner bracket
⁺         plus superscript
⁻         minus superscript
⁰         0 superscript
¹         1 superscript 
²         2 superscript 
³         3 superscript 
⁴         4 superscript 
⁵         5 superscript 
⁶         6 superscript 
⁷         7 superscript 
⁸         8 superscript 
⁹         9 superscript 
EOF
;

# use this without -xos4-terminus-medium-r-*-*-10-* font
# the default font may change given which font packages are installed and given the font configurations

#print $FH <<'EOF'
#«         hyper operator
#»         hyper operator
#∈         membership
#∉         non-membership
#∪         set union
#∩         set intersection
#∖         set difference
#≡         set equality
#≢         set inequality
#⊖         symmetric set difference
#⊍         baggy multiplication
#⊎         baggy addition
#∅         empty set
#⊆         subset
#⊈         not a subset
#⊂         strict subset
#⊄         not a strict subset
#∋         reverse membership
#∌         reverse non-membership
#⊇         superset
#⊉         not a superset
#⊃         strict superset
#⊅         not a strict superset
#∞         infinity
#⚛         atomic operator
#π         pi
#τ         tau
#𝑒         Euler's number
#∘         function composition
#×         multiplication 
#÷         division
#≤         inferior or equal
#≥         greater or equal
#≠         inequality
#−         substraction
#≅         approximatively equal
#…         sequence operator
#‘         left single quotation mark
#’         right single quotation mark
#‚         single low-9 quotation mark 
#”         right double quotation mark
#“         left double quotation mark
#„         double low-9 quotation mark
#｢         halfwidth left corner bracket
#｣         halfwidth right corner bracket
#⁺         plus superscript
#⁻         minus superscript
#⁰         0 superscript
#¹         1 superscript 
#²         2 superscript 
#³         3 superscript 
#⁴         4 superscript 
#⁵         5 superscript 
#⁶         6 superscript 
#⁷         7 superscript 
#⁸         8 superscript 
#⁹         9 superscript 
#EOF
#;



close $FH;



__END__


=pod 

=head1 NAME

lazy_raku_unicode.pl

=head1 SYNOPSIS

This script allows you to select a Unicode symbol from a drop-down menu that you can simply paste into your text editor, terminal or IDE.

All it does is send a heredoc through a pipe to dmenu, and copy to the clipboard the character that you selected.

Dmenu is a program that reads lines from stdin, display them in a menu, and write to stdout the lines selected.

It is not practical to execute this script from a terminal each time you want a character though. This is why it should be executed by sxhkd.

Sxhkd is the program that will call this script each time you press the right key combination.

Only the most useful Unicode characters are present to not make dmenu get too slow. (It is usually very fast when there is only ascii text.)

This include most of the Raku operators that have a Unicode version, plus some quoting characters, superscripts, and mathematical constants.

=head1 MANUAL INSTALLATION STEPS


=head2 INSTALLING DMENU

B<On Debian or Ubuntu :>

	sudo apt install suckless-tools

B<On Archlinux :>

	sudo pacman -Sy dmenu

B<Compile it from source :>

	https://tools.suckless.org/dmenu/

=head2 CHANGING DMENU FONT SIZE (OPTIIONAL)

You have only two ways of changing the font size :

Change the default font with the B<-fn> flag (See dmenu(1) for the specifics).
	
	dmenu -l 30 -fn '-xos4-terminus-medium-r-*-*-10-*'


Modify directly the C source code of dmenu. Only the files B<config.h / config.def.h>.

Simply edit this line and change 10 by 14 for example.

	static const char *fonts[] = {
		"monospace:size=10"
	};

Then execute sudo make install and you're ready to go.

=head2 INSTALLING SXHKD


B<On Debian or Ubuntu :>

	sudo apt install sxhkd

B<On Archlinux :>

	sudo pacman -Sy sxhkd


=head2 CONFIGURING SXHKD

B<Autostarting sxhkd at startup :>

simply put this line in B<~/.xprofile> :

	sxhkd &


B<Setting the keybinding :>
	

Add these two lines in B<~/.config/sxhkd/sxhkdrc>

	ctrl + apostrophe
		/path/to/lazy_raku_unicode.pl

The keybinding have to start at the beginning of a line, and the command has to follow on the next line and be preceded by a tabulation.

To make sxhkd reload the config file, either kill it and relaunch it, or send a SIGUSR1 signal. This command can do it :

	pidof sxhkd | kill -SIGUSR1 $(cat /dev/stdin)

If you want to use a different keybinding, please see sxhkd(1) and use xev(1) to find the name of keys.

Here the name of some of the keys : ctrl, super, alt, Return .

=head1 SEE ALSO

dmenu(1), sxhkd(1), xev(1)


=cut







