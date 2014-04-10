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
            mv $i -Destination "~\Pictures"
        }
        {$vid -contains $_} {
            mv $i -Destination "~\Videos"
        }
        {$mus -contains $_} {
            mv $i -Destination "~\Music"
        }
        {$doc -contains $_} {
            mv $i -Destination "~\Documents"
        }
    }
    
}

# No place like home
pop-location

echo "Done!"
sleep 2
