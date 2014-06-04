######################################################################################
# Download sorter written by: 
#   Joshua "MrSchism" Embrey [mrschism@sdf.org]
#   Joseph "Arcarna" Preston [jpreston86@gmail.com]
# Intial commit: April 9, 2014(20140409)
# Current version: June 4, 2014(20140604)
#
# Purpose:	Move files from ~\Downloads to appropriate folder	  
######################################################################################

# Initialize arrays of common file types
$img = ".jpg",".png",".gif",".bmp"
$vid = ".avi",".mp4",".mov",".wmv",".webm",".3gp",".flv"
$mus = ".mp3",".flac",".ogg",".wav", ".wma", ".aac"
$doc = ".doc",".odt",".docx",".txt",".rtf",".pdf"

# Set counters to 0
# Moved files
$imgmoved = 0
$vidmoved = 0
$musmoved = 0
$docmoved = 0
$totmoved = 0

# Unmoved files
$imgstayed = 0
$vidstayed = 0
$musstayed = 0
$docstayed = 0
$totstayed = 0

# Whitelist for flags
$flags = "-h","-v","-vv","/h","/v","/vv",$null

# Function for sums
function sums {
    $script:totmoved = $script:imgmoved + $script:vidmoved + $script:musmoved + $script:docmoved
    $script:totstayed = $script:imgstayed + $script:vidstayed + $script:musstayed + $script:docstayed
}

# Functions for verbosity
function v1 {
    sums
    echo "$totmoved files were moved; $totstayed files were not moved."
    if ($totstayed -gt 0) {
        echo "`nFor better results, consider defining locations for filetypes in the script.`n"
    }
    sleep 2
}

function v2 {
    sums
    echo "$totmoved files were moved; $totstayed files were not moved."
    echo "This breaks down as follows:"
    echo "Image:`n`tMoved: $imgmoved`n`tUnmoved: $imgstayed"
    echo "Video:`n`tMoved: $vidmoved`n`tUnmoved: $vidstayed"
    echo "Audio:`n`tMoved: $musmoved`n`tUnmoved: $musstayed"
    echo "Documents:`n`tMoved: $docmoved`n`tUnmoved: $docstayed"

    if ($totstayed -gt 0) {
        echo "`nFor better results, consider defining locations for filetypes in the script.`n"
    }
    sleep 2
}

# Notifies if using invalid flags:
if ($flags -notcontains $args[0]) {
    echo "Invalid flag.  Running in normal mode.  Run with -h flag for more information."
}


# Help information
if (($args[0] -eq "/h") -or ($args[0] -eq "-h")) {
    echo "`n  Download File Sorter - "
    echo "  Created by Joshua `"MrSchism`" Embrey and Joseph `"Arcarna`" Preston"
    echo "  mrschism@sdf.org  |  MIT license 2014`n"
    echo "  This script checks a file's extension in ~/Downloads and attempts to move it to the appropriate folder."
    echo "`n`t/h or -h   : Produces this help dialog."
    echo "`t/v or -v   : Slightly verbose stats included"
    echo "`t/vv or -vv : More verbose stats included`n`n"
}

else {
    # Save where you are, then move to ~\Downloads
    push-location
    cd ~\Downloads

    echo "`n`nChecking for files and moving if necessary...`n"
    foreach ($i in ls) {
    
        switch ($i.extension) {
            {$img -contains $_} {
                $chk = test-path "~\Pictures\$i"
                if ($chk -eq $true) {
                    echo "`tA file named $i already exists in ~\Pictures."
                    $imgstayed++
                    }
                elseif ($chk -eq $false) {
                    mv $i -Destination "~\Pictures"
                    $imgmoved++
                }
            }
            {$vid -contains $_} {
                $chk = test-path "~\Videos\$i"
                if ($chk -eq $true) {
                    echo "A file named $i already exists in ~\Videos."
                    $vidstayed++
                    }
                elseif ($chk -eq $false) {
                    mv $i -Destination "~\Videos"
                    $vidmoved++
                }
            }
            {$mus -contains $_} {
                $chk = test-path "~\Music\$i"
                if ($chk -eq $true) {
                    echo "A file named $i already exists in ~\Music."
                    $musstayed++
                    }
                elseif ($chk -eq $false) {
                    mv $i -Destination "~\Music"
                    $musmoved++
                }
            }
            {$doc -contains $_} {
                $chk = test-path "~\Documents\$i"
                if ($chk -eq $true) {
                    echo "A file named $i already exists in ~\Documents."
                    $docstayed++
                    }
                elseif ($chk -eq $false) {
                    mv $i -Destination "~\Documents"
                    $docmoved++
                }
            }
        }
    }

    # No place like home
    pop-location

    # Output
    echo "`nDone!"
    sleep 2
    echo "`n"

    # Ask if metrics are desired
    if ($args[0] -eq $null){
        echo "`n---------------------------------------"
        echo "Would you like to see detailed results?"
        echo "`nY: Yes`nV: Verbose`nN: No`n`nDefault: NO"
        $q = read-host "y/v/N"
        echo "`n"
        switch ($q) {
            "y" {
                # Be verbose
                v1 
            }
            "v" {
                # Be verbose-ier
                v2
            }
            "n" {
                echo "Thank you."
                sleep 2
            }
            default {
                echo "Thank you."
                sleep 2
            }
        }
    }
    if (($args[0] -eq "-v") -or ($args[0] -eq "/v")) {
        v1
    }
    elseif (($args[0] -eq "-vv") -or ($args[0] -eq "/vv")) {
        v2
    }
}
