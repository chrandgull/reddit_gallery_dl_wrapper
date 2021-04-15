#!/bin/bash

set -e  #Any errors, quit

subreddit=$1
downloadDir=$2

#Did we specify the subreddit we want to download?

if [ "$1" == "" ]; then
    echo "Subreddit not specified"
	exit 1
fi

if [ "$2" == "" ]; then
    echo "Download directory not specified"
	exit 1
fi


#If user specified a trailing slash on download directory name, get rid of it. 



numberOfCharsInDirectory=`echo -n ${downloadDir} | wc -m`
lastCharInDownloadDirectory=`echo -n ${downloadDir} | cut -c${numberOfCharsInDirectory}`

if [ ${lastCharInDownloadDirectory} == "/" ]; then
   downloadDir=`echo ${downloadDir} | sed 's/.$//'`
fi

exit 0
#Set up paths

archiveName=${downloadDir}/${subreddit}/archive
downloadDir=${downloadDir}/${subreddit};
lockfile=${downloadDir}/${subreddit}/lockfile

#Each to verify

echo "Lock file name is: " $lockfile
echo "Download directory is:"  ${downloadDir}
echo "Archive file name is: " $archiveName

#exit 0

#Does the download directory exist?

if [ -d "${downloadDir}" ]
then
	echo "Directory ${downloadDir}/${subreddit} exists already"
else
	`mkdir -p ${downloadDir}/${subreddit}`
	 echo "Directory ${downloadDir}/${subreddit} created"
fi

#Check for lockfile

if [ -f "${lockfile}" ]; then
		echo "${lockfile} already exists. Exit with CC 1"
		exit 1
fi

#Create lockfile

`touch ${lockfile}`

#Run command

command gallery-dl --quiet --download-archive ${archiveName} --dest ${downloadDir} reddit.com/r/${subreddit}

#Cleanup. Lockfile should be there, but check just in case.

if [ -f "${lockfile}" ]; then
		`rm ${lockfile}`
        echo "${lockfile} deleted"
fi

