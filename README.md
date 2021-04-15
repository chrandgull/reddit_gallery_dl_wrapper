Reddit gallery-dl wrapper

This shell script is a small wrapper around gallery-dl for reddit.

It is ideal for automating the collection of images from your favorite subreddits.

## How to run it:

To download all of the current posts on /r/funny, pass two operands. 

./pics_download.sh funny my_download_directory

Operand one: The subreddit you want to download
Operand two: The directory you want to place your downloaded files in.

## Usage notes

The shell script makes use of gallery-dl's archive functionality. It will create an SQLite database containing all of the photos you have downloaded, and will not download them twice.

The shell script also creates a 'lockfile' during processing. If the script is interrupted, you will need to manually delete the lockfile. Otherwise it will self delete once processing is done. 
