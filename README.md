# About

Anchor allows to anchor a directory as a custom alias. This is useful when you are working on a project in an existing directory
and have the tendancy to open many terminals and multitask in the same directory. This allows to quickly and conveniently cd into that anchored directory everytime you open a new terminal without the need to specify the fullpath everytime. Or it is also useful when you are coming back to the project you are working on.



# Installation Instructions

	1. ./install.sh  - To install the program run the installation script

This script compiles the program and moves the executable into your /usr/bin. This allows you to call the program
from any directory.

# Re-installation Instructions

If you wish to edit/extend the program in anyway, be it changing an option in the config or extending
the source code of the program. Follow these steps when you are ready to re-install the program:

	1. ./reset.sh    - this resets the bashrc file and .anchor to the original files.
	2. ./install.sh  - this intallation script, creates a backup of .bashrc, which reset.sh uses to revert to your
			   original .bashrc and once done, it then installs the program as mentioned prior.




# Instruction Usage

	1. anchor p	- this prints the current anchored directory to stdout.
	2. anchor a x   - the a flag means to anchor directory x, where x is provided by the user.
	3. anchor	- if you run the program with no flags, this anchors the directory which the program was called in.
			  (which is useful if you are already in the directory you wish to anchor)



The anchor is then saved as a custom alias key within .bashrc. calling with flag 'p' will show you the alias key
for cd'ing into the anchored directory. However you can change the alias key for your preferences.


The default alias key is 'd' which takes you to the anchored directory. However if you wish to change this, then in
/config/config.h you can change the key. *AGAIN* if you edit the config.h or the src/anchor.c in anyway which requires
re-installation, PLEASE follow the instructions in *reinstallation instructions* section prior.

