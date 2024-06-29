#!/bin/bash

lastupdated=202312290855

# MateusAuri's
# Steam Library 'What's New' Yeeter script
# Modified for Linux by Eli

# What's this?
#     This batch/powershell script hides that annoying "What's New" shelf or section from your Steam Library

# Use instructions:
#     - Navigate to your Steam install directory (in my case "/home/<user>/.steam/")
#     - Naviagte to "steamui\css"
#     - Copy this script into the "css" folder (it should be in the same folder as "chunk~2dcc5aaf7.css")
#     - Open a terminal in this directory
#     - Run the following command: bash SteamWhatsNewYeeter.sh 
#     - Repeat the previous step whenever "What's New" pops back again into your library or set up a cron job

echo
echo "--------------------------------------------"
echo "|               MateusAuri's               |"
echo "| Steam Library 'What's New' Yeeter script |"
echo "|         Modified for Linux by Eli        |"
echo "|           Version $lastupdated           |"
echo "--------------------------------------------"

# Check if Steam is running
steamisrunning=1
echo
echo "Checking if Steam is running..."
if pgrep steam > /dev/null || pgrep steamservice > /dev/null || pgrep steamwebhelper > /dev/null; then
    steamisrunning=1
    echo
    echo "Steam seems to be running"
    echo "But don't fret, I'll deal with that for you"
else
    steamisrunning=0
    echo
    echo "Steam is not running, that's nice!"
fi

# Modifies file to remove the relevant snippet if present
apply_the_thing() {
    echo
    # Kills Steam process until it's dead
    if [ $steamisrunning -eq 1 ]; then
        echo "Killing Steam processes..."
        pkill steam
        sleep 5
        pkill steamwebhelper
        sleep 5
        pkill steamservice
    fi

    echo "Backing the 'chunk~2dcc5aaf7.css' file up into 'chunk~2dcc5aaf7.css.bak'..."
    cp chunk~2dcc5aaf7.css chunk~2dcc5aaf7.css.bak

    # height:324px is what tells the UI to display the what's new section
    # Replacing this with display:none prevents the what's new section from being rendered
    echo "Yeeting 'What's New'..."
    sed -i 's/height:324px/display:none/g' chunk~2dcc5aaf7.css

    echo "Verifying modification..."
    if grep -q "display:none" chunk~2dcc5aaf7.css; then
        echo "Modification successful"
    else
        echo "Modification failed"
    fi

    echo "Trimming some rough edges..."
    # Read all bytes, remove the last 3 bytes to fool steam into thinking the file is the same size
    # If the file size does not match what steam expects, the whole file is replaced on launch and our modificaitons are lost
    file_content=$(<chunk~2dcc5aaf7.css)
    new_content="${file_content:0:-3}"

    if [ $steamisrunning -eq 1 ]; then
        echo "Reopening Steam..."
        sleep 2
        ../../steam.sh -nofriendsui &> /dev/null &
    fi

    echo
    echo "Done!"
}

# Check if the file is already modified
if [ ! -f chunk~2dcc5aaf7.css ]; then
    echo
    echo "Hey, wait a minute, I can't find the 'chunk~2dcc5aaf7.css' file!"
    echo "Please make sure that you're running this script from inside the 'steamui/css' folder"
    echo "Full path is probably '/path/to/steam/steamui/css' for you"
    echo "It should have a file called 'chunk~2dcc5aaf7.css' in there"
elif grep -q "height:324px" chunk~2dcc5aaf7.css; then
    apply_the_thing
else
    echo
    echo "Wait, 'chunk~2dcc5aaf7.css' seems to be modified already"
    echo "Which means that the 'What's New' shelf has already been yeeted (for now)"
fi

# Wraps it up
echo
echo "If you liked this script and would really really like to thank me,"
echo "Please consider throwing a dollar or so at me, because I'm broke af right now"
echo
echo "Donation links and updates at"
echo "https://github.com/MateusAuri/SteamWhatsNewYeeter"
echo
echo "Okay, exiting script now..."
echo "Enjoy your uncluttered library! :)"
echo "Bye!"
echo
