#!/bin/bash

# This script will handle symlinking your vimrc to the proper location
# in this repo

# Terminal color constants
readonly BLACK=0
readonly RED=1
readonly GREEN=2
readonly WHITE=7

# Names for using the colors
readonly SUCCESS=$GREEN
readonly ERROR=$RED
readonly INFO=$WHITE

function log {
	tput setaf $1
	echo $2
	# reset
}

function symLinkFile {
	if [ -d $1 ]; then
		log $SUCCESS "[OK!] dotfiles repo found!"
		# preserve user's existing vimrc if it exists
		if [ -f $3 ]; then
			# create backup name for file
			date=$(date +%Y-%m-%d:%H:%M:%S)
			backupname="$3-$date"
			log $INFO "Creating backup of existing $3 as $backupname"
			mv $3 "$3-backup-$(date)"
		fi
		ln -s $2 $3
		log $SUCCESS "[OK!] Symlink Created Successfully!"
	else
		log $ERROR "[FAIL!] No dotfiles directory found in your home folder!"
		return
	fi
}

# Script execution starts here

log $INFO "This script will symlink to the dotfiles repo .vimrc configuration!"
cd ~
symLinkFile "dotfiles" "dotfiles/config/vim/init.vimrc" ".vimrc"
log $INFO "Script finished"
