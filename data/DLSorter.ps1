######################################################################################
# Download sorter written by: 
#   Joshua "MrSchism" Embrey [mrschism@sdf.org]
#   Joseph "Arcarna" Preston [jpreston86@gmail.com]
# Intial commit: April 9, 2014(20140409)
# Current version: April 9, 2014(20140409)
#
# Purpose:	Move files from ~\Downloads to appropriate folder	  
######################################################################################

# Initialize arrays of common file types
$img = ".jpg",".png",".gif",".bmp"
$vid = ".avi",".mp4",".mov",".wmv",".webm",".3gp",".flv"
$mus = ".mp3",".flac",".ogg",".wav", ".wma", ".aac"
$doc = ".doc",".odt",".docx",".txt",".rtf",".pdf"

# Save where you are, then move to ~\Downloads
push-location
cd ~\Downloads

foreach ($i in ls) {
    
    switch ($i.extension) {
        {$img -contains $_} {
            $chk = test-path "~\Pictures\$i"
            if ($chk -eq $true) {
                echo "A file named $i already exists in ~\Pictures."
                }
            elseif ($chk -eq $false) {
                mv $i -Destination "~\Pictures"
            }
        }
        {$vid -contains $_} {
            $chk = test-path "~\Videos\$i"
            if ($chk -eq $true) {
                echo "A file named $i already exists in ~\Videos."
                }
            elseif ($chk -eq $false) {
                mv $i -Destination "~\Videos"
            }
        }
        {$mus -contains $_} {
            $chk = test-path "~\Music\$i"
            if ($chk -eq $true) {
                echo "A file named $i already exists in ~\Music."
                }
            elseif ($chk -eq $false) {
                mv $i -Destination "~\Music"
            }
        }
        {$doc -contains $_} {
            $chk = test-path "~\Documents\$i"
            if ($chk -eq $true) {
                echo "A file named $i already exists in ~\Documents."
                }
            elseif ($chk -eq $false) {
                mv $i -Destination "~\Documents"
            }
        }
    }
    
}

# No place like home
pop-location

echo "Done!"
sleep 2
