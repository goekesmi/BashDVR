# BashDVR 
This is a set of scripting tools that let one run a lot of parallel 
automated restarting youtube-dl instances that upload the results 
of their content to S3.

The required set of software includes:
 * ffmpeg
 * screen
 * youtube-dl
 * aws command line tooling

This has been tested in linux on AWS EC2 instances.  It's expected that
it would work anywhere with the above software on a reasonable unix like
system.

# Configuration

It is expected that you will have a series of directories in this tree.
Each directory is a channel, and contains a single file called URL.  The 
file contains a URL that will be passed to youtube-dl.

# Operation

You are expected to already be in a screen session when you run these
tools.

Want to run one?  Starting in this directory, run startWatcher.sh <directory>.
The job will start in the console and run so you can inpect the process.

Want to run all of them? Starting in the directory, run startAll.sh.  This will launch a copy of startWatcher.sh for each directory here, in a new screen
window, named after the directory/channel name.

Once up and running, the loop will attempt to execute youtube-dl against the
url.  When youtube-dl ends, any .mp4 files will attempt to be uploaded to
the specified bucket.  A 40 second pause will happen, and then the process
begins again.  Forever.

The 'any .mp4' selection of upload accounts for failures to upload with
`aws s3 mv ` by not deleting the file if the upload fails, and trying again
later.

If the twitch stream is offline, youtube-dl will terminate and enter the 40
second sleep.

If you are in the 40 second sleep, a ctrl-c will kill off the process.

If the stream ends because the broadcaster stopped, the shutdown is normal
and a file of the stream will get pushed to s3.

If the streamer is impressively 24/7, you will need to check the stream to 
see if you are at an okay break point, and ctrl-c youtube-dl.  This will
result in the download ending, and the file(s) being shoved into S3, before
picking up the stream again.

The most expensive part of this operation is the youtube-dl startup.  During
sleep or capture, CPU usage is very low.  But 40 copies of youtube-dl starting
up every 40 seconds will swamp a single core system.


