# Steam Library 'What's New' Yeeter script

## What's this?
- This is a bash script for Linux systems that hides the annoying "What's New" section from your Steam Library based on MateusAuri's [Windows script](https://github.com/MateusAuri/SteamWhatsNewYeeter/tree/latest)

## How do I use it?
1. Navigate to your Steam install directory (in my case `/home/[user]/.steam/` when installed using the apt package manager, flatpak will likely differ)
2. Naviagte to "steamui\css"
3. Copy this script into the "css" folder (it should be in the same folder as "chunk~2dcc5aaf7.css")
4. Open a terminal in this directory (in my case `/home/[user]/.steam/steam/steamui/css/`)
5. Run the following command in the terminal: `bash SteamWhatsNewYeeter.sh`
6. (Optional) Set up a cronjob to run the script regularly:
    1. In the same terminal, run the command `crontab -e`
    2. using your favorite editor, add the following line to the end of your crontab: `0 12 * * * bash /home/[user]/.steam/steam/steamui/css/SteamWhatsNewYeeter.sh`
    3. Save and close the file

## How do I download it?
You can download the script directly by right clicking the SteamWhatsNewYeeter.sh file above and clicking "Save link as..."
