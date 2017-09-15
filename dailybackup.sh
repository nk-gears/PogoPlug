#!/bin/bash

# Daily Backup Script which backs up the Applications folder to a NAS connected with SMB

#############
# Variables #
#############

RSYNC_LOG="/home/pogoplug/applications/backup/logs/rsync.log"
BACKUP_LOG="/home/pogoplug/applications/backup/logs/backup.log"

BACKUP_LOCATION="/home/pogoplug/Backup"
ERRORVALUE=0

PUSHBULLET_SCRIPT="/home/pogoplug/applications/pushbullet.sh"

#############
# Functions #
#############

function mountCheck () {
	if [[ $(mount | grep -c $1) == 0 ]]; then

	# Error - Media is not mounted. Sending Message to Sysadmin
	$PUSHBULLET_SCRIPT "ERROR - \"$1\" not Mounted" "During Daily Backup, the mount check of \"$1\" failed." >/dev/null 2>&1
	exit 1
	fi
}

function errorCheck () {
	ERRORVALUE="$?"
	if [ $ERRORVALUE -ne 0 ]; then
  		$PUSHBULLET_SCRIPT "ERROR - PogoPlug Backup failed" "During daily backup, rsync failed backing up files (error code different than 0)." >/dev/null 2>&1
		exit 1
	fi
}

function backup () {
	# This function expects 2 arguments, the backup location & the folder you want to restore
	printf "Backing up %s to %s\n" "$1" "$2" >> $BACKUP_LOG 2>&1
	rsync --log-file=$RSYNC_LOG -avhP --delete "$1/" "$2" >/dev/null 2>&1

	errorCheck
}

#################
# Backup Script #
#################

printf "Starting Daily Backup. Time & Date right now is $(date)\n" >> $BACKUP_LOG 2>&1

# Checking if Media & Backup is mounted
printf "Checking if Backup is successfully mounted\n" >> $BACKUP_LOG 2>&1

mountCheck $BACKUP_LOCATION

# Backing up applications to Backup
backup /home/pogoplug/applications $BACKUP_LOCATION/applications

# Ending backup
printf "End of Daily Backup.\n\n" >> $BACKUP_LOG 2>&1
exit 0