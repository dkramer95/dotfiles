#!/bin/bash

# unix-setup.sh
# Author: David Kramer
# Last Updated: 06/22/17

# Overview
# This script is intended to quickly setup a new unix based machine with common
# development tools and other useful utilities that will greatly improve
# workflow effiency. It will load in all the necessary dotfile configs and
# handle linking them up and will ask the user for each file if they wish to
# have it linked.

# Logging Stuff

# Terminal color constants
readonly RED=1
readonly GREEN=2
readonly YELLOW=3

# Names for using the colors
readonly SUCCESS=$GREEN
readonly ERROR=$RED
readonly WARNING=$YELLOW

# Prints message to the console in green text indicating success
function log {
	tput setaf $SUCCESS
	echo -e $1
}

# Prints message to the console in yellow text indicating a warning
function warn {
	tput setaf $WARNING
	echo -e $1
}

# Prints message to the console in red text indicating an error
function error {
	tput setaf $ERROR
	echo -e $1
}

# Prints 'normal' date
function myDate {
	result=$(date +%Y-%m-%d)
	echo $result
}

# Creates a symlink to the specified destination. If there already
# exists a file with the same name, it will be preserved and
# appended with the current date
function symLinkWithBackup {
	local sympath=$1 # What we are linking to
	local symname=$2 # Name of the symlink we're creating
	local backupDir=$3 # Where we want to store symlinks that may already exist

	# Check if file exists with the same name
	if [ -f $symname ]; then
		# create backup name for file
		backupName="$symname-old"
		warn "Creating backup of existing [$symname] as [$backupName]"
		mv $symname $backupDir/$backupName
	fi
	ln -s $sympath $symname
	log "[OK!] Created Symlink: [$symname]->[$sympath]\n"
}

# Installs the specified package if it is not found on the system
function installPackage {
	local packageManager=$1
	local packageName=$2

	if [ -z $(which $packageName) ]; then
		log "[$packageName]\n\tinstalling missing package"
		$packageManager install $packageName
	else
		log "[$packageName]\n\talready installed!"
	fi
}

# Determines the package manager based on the current OS.
# NOTE -- If on OS X, Homebrew will automatically be installed if
# it is not found.
# TODO -- Debian 'apt-get' and 'brew' are only supported right now
function getPackageManager {
	local OS=$(uname -s)

	if [ $OS = "Darwin" ]; then
		# MacOS
		if [ -z $(which brew) ]; then
			log "Installing homebrew -- the missing package manager for MacOS"
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
		echo "brew"
	else
		echo "apt-get"
	fi
}

# Reads from the specified package list file.
function readPackageList {
	local packageList=$1

	# Delimiter for ignoring lines
	local ignoreDelim="#"

	local result=$(cat $packageList | sed "s/$ignoreDelim.*$//")
	echo $result
}


# Uses the system package manager to update and install all packages
# that are defined in the package file
function installMissingPackages {
	local packageFile=$USER_HOME/dotfiles/scripts/packages.txt
	local packages=$(readPackageList $packageFile)
	local packageManager=$(getPackageManager)

	# Ensure package manager has latest versions of packages
	log "Updating existing packages from [$packageManager]"
	$packageManager update

	# Install packages defined in packages.txt
	for pkg in ${packages[@]}; do
		installPackage $packageManager $pkg
	done
}

# Creates the specified backup directory if it doesn't exist already
function createBackupDirIfNotExists {
	local backupDir=$1

	# Create backupdir to house possible existing user dotfiles
	if ! [ -d $backupDir ]; then
		log "Creating backup directory: [$backupDir]"
		mkdir $backupDir
	fi
}

# Checks to make sure that this dotfiles repo exists
function ensureDotfilesExist {
	local dotfilesDir=$1
	# Ensure that dotfiles directory exists in the user's home folder
	if ! [ -d $dotfilesDir ]; then
		error "[ERROR!] No dotfiles directory found in [$USER_HOME]"
		exit -1
	fi
}

# Creates symlinks to all dotfiles in this repo
function symLinkDotFiles {
	cd $USER_HOME

	# Where all the dotfiles live
	local dotfilesDir="$USER_HOME/dotfiles"
	local backupDir="$USER_HOME/olddotfiles-$(myDate)"

	ensureDotfilesExist $dotfilesDir
	createBackupDirIfNotExists "$USER_HOME/olddotfiles-$(myDate)"

	# Get only hidden files and filter out .git stuff and './ and ../'
	local dotfiles=$(ls -a $USER_HOME/dotfiles | grep '^\.' | sed -e 's/.git$//' -e 's/\.\{1,2\}$//')

	local j=1
	local count=$(sed '/^\s*$/d' <<< "$dotfiles" | wc -l | awk ' { print $1 }')

	for file in $dotfiles; do
		# Check to make sure we're not linking to a directory
		if ! [ -d $file ]; then
			# Prompt user if they want to link with the dotfile
			while true; do
				log "" # clear error colors if they exist
				read -p "[$j / $count] Do you wish to link [$file]? Y[es] or N[o] > " yn
				case $yn in
					[Yy]* ) symLinkWithBackup "$dotfilesDir/$file" $file $backupDir; break;;
					[Nn]* ) break;;
					* ) error "[ERROR!] Invalid input:[$yn] Please enter Y[es] or N[o]!";;
				esac
			done
			j=$((j+1))
		fi
	done
}

# Get home directory of the user
function getUserDir {
	if [ "$EUID" -eq 0 ]; then
		# Run as root
		USER_HOME=$(eval echo ~${SUDO_USER})
	else
		# Run as a normal user
		USER_HOME=$(env | grep 'HOME=.*' | cut -d= -f2)
	fi
}

# Handles executing everything that is necessary
function run {
	log "+++Executing setup script+++"

	vim packages.txt

	# Update $USER_HOME variable
	getUserDir

	# Do awesome things
	installMissingPackages
	symLinkDotFiles
	log "+++Finished!+++"
}




# Starting point
run
