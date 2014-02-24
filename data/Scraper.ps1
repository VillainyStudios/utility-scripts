######################################################################################
# File Scraper written by: 
#   Joshua "MrSchism" Embrey [mrschism@sdf.org]
#   Joseph "Arcarna" Preston [jpreston86@gmail.com]
# Intial commit: February 10, 2014 (20140210)
# Current version: February 11, 2014(20140211)
#
# Purpose:	File scraper checks a file selected by the user and		  
# 		searches for all instances of a string or values supplied 
# 		by the user.  Initially designed to find all instances of 
# 		"<div role="note">", the text in it, and "</div>"	      
######################################################################################

# Declare variables
$cycle = "yes"                 # Allows script to be re-run without re-calling it
$file = ""                     # File to be searched
$find = ""                     # Value to be found
$type = ""                     # Type of data to find
$valid = 1,"string",2,"RegEx"  # Allowed responses
$result = ""                   # Output results
$output = ""                   # How to output the results
$again = ""                    # Search for another string


# Formatting for the output
$format = @{expression={$_.linenumber};label="Line";width=5},@{expression={$_.line};label="Data"}

# Main loop
cls
while ($cycle -eq "yes") {
    
    # Determine what file to scrape
    echo "Which file would you like to scrape?"
    while ($file -eq "") {
        $file = read-host "File"
    }
    

    # Determine type of scraping will need to be done
    echo "--------------------------------------------------"
    echo "`n`nWhich of the following will you be scraping for:"
    echo ""
    echo "1. String"
    echo "2. RegEx"
    echo "`n`n"
    while ($valid -notcontains $type) {
        $type = read-host "Please select which you will be scraping for"
    }

    # Set string and regex to their numerical values for simplicity
    if ($type -eq "string") {
        $type = 1
        echo "`n Scraping for a String"
    }
    
    if ($type -eq "regex") {
        $type = 2
        echo "`n`n Scraping for a RegEx"
    }

        

    # Determine what we are scraping for
    echo "--------------------------------------------------"
    echo "`n`nWhat would you like to find?"
    while ($find -eq "") {
        $find = read-host "Find"
    }


    # Scrape $file for $find based on $type
    switch ($type) {
        
        # For string searches
        1 {
            push-location
            cd "C:\"
            $result = select-string -simple $find $file | select LineNumber,Line `
                | format-table $format -auto -wrap | foreach-object {$_; echo ""} | out-string -width 1000000
            echo "--------------------------------------------------"
            echo "Scraping $file for `"$find`"..."
            $result
            pop-location
            
        }
        
        # For RegEx searches
        2 {
            push-location
            cd "C:\"
            echo "--------------------------------------------------"
            echo "Scraping $file for `"$find`"..."
            $result = select-string $find $file | select LineNumber,Line `
                | format-table $format -auto -wrap | foreach-object {$_; echo ""} | out-string -width 1000000
            $result
            pop-location
            
        }
    
    
    }
    
    # Prompt to search again or exit
    echo "--------------------------------------------------"
    while (($again -ne "y") -and ($again -ne "n")) {
        $again =  read-host "Would you like to search again? (y/n)"}
    if ($again -eq "n") {
        $cycle = "no"
    }
    else {
        $file = ""
        $find = ""
        $type = ""
        $result = ""
        $output = ""
        $again = ""
        echo "####################NEW SEARCH####################"
        echo "--------------------------------------------------"
        echo ""
    }
    
    
}
