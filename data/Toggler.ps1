######################################################################################
# Task Manager Toggler written by: 									
#   Joshua "MrSchism" Embrey [mrschism@sdf.org]					
#   Joseph "Arcarna" Preston [jpreston86@gmail.com]					
# Intial commit: February 5, 2014 							
# Current version: February 12, 2014							
######################################################################################

# Variables
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System\'
$tog = 0
$ans = ""
$zen = ""
$avail = 1
$run = 1
# Whitelist array for input
$valid = "yes","no","y","n",1,2,"q"

$title = {########################
# Task Manager Toggler #
########################

} 


while ($run -eq 1) {
    # Start clean
    cls

    # Throw the title
    $title

    # Check for key existence and offer to make it if absent.
    if(!(Get-ItemProperty $key -Name DisableTaskMgr -ea 0)){
        $avail = 0
        'Task Manager is not controlled by registry.'
        'Would you like to create the registry value?'
        ''
        '1. yes'
        '2. no'
        ''
        'Press Q to quit'
        while ($valid -notcontains $ans) {
            $ans = read-host
        }
    
        if (($ans -eq "y") -or ($ans -eq "yes")) {$ans = 1}
        if (($ans -eq "n") -or ($ans -eq "no")) {$ans = 2}
    
        switch ($ans) {

            1 {(md $key) > $null
                cls
                $avail = 1
                New-ItemProperty "$key" -Name "DisableTaskMgr" -Value 0 -PropertyType "DWord" >$null
                $title
                "Task Manager is now able to be toggled."
                ''
                }

            2 {''
                "Feel free to change your mind any time..."
                sleep 2
                }
            
            "q" {'Exiting program...'
                sleep 2
                cls
                $run = 0
                }
            
            default {
                ''
                "Feel free to change your mind any time..."
                sleep 2
                }

        }
    }

    # States if the task manager is enabled and sets the toggle ($tog) variable
    if ($avail -eq 1) {
        if(((Get-ItemProperty -Path $key -Name DisableTaskMgr).DisableTaskMgr) -eq 0) {
            'Task Manager is currently [ENABLED]'
            $tog = 0}
        elseif(((Get-ItemProperty -Path $key -Name DisableTaskMgr).DisableTaskMgr) -eq 1) {
            'Task Manager is currently [DISABLED]'
            $tog = 1}

        # Offers to enable or disable based on the state of $tog
        if ($tog -eq 0) {
            'Would you like to DISABLE Task Manager?'
            ''
            '1. yes'
            '2. no'
            ''
            'Press Q to quit'
            while ($valid -notcontains $zen) {
                $zen = read-host
            }
        
            if (($ans -eq "y") -or ($ans -eq "yes")) {$ans = 1}
            if (($ans -eq "n") -or ($ans -eq "no")) {$ans = 2}
                
                switch ($zen) {

                1 {set-itemproperty -path $key -name DisableTaskMgr -value 1
                    ''
                    'Task Manager has been DISABLED.'
                    sleep 1
                    }

                2 {''
                    "Feel free to change your mind any time..."
                    sleep 2
                    }
                            
                "q" {'Exiting program...'
                    sleep 2
                    cls
                    $run = 0
                    }

                default {''
                    "Feel free to change your mind any time..."
                    sleep 2
                    }
                }
        }
        
        if ($tog -eq 1) {
            'Would you like to ENABLE Task Manager?'
            ''
            '1. yes'
            '2. no'
            ''
            'Press Q to quit'
            while ($valid -notcontains $zen) {
                $zen = read-host
                }
                if (($ans -eq "y") -or ($ans -eq "yes")) {$ans = 1}
                if (($ans -eq "n") -or ($ans -eq "no")) {$ans = 2}
                switch ($zen) {

                    1 {set-itemproperty -path $key -name DisableTaskMgr -value 0
                        ''
                        'Task Manager has been ENABLED.'
                        sleep 1
                        }

                    2 {''
                        "Feel free to change your mind any time..."
                        sleep 2
                        }
                        
                    "q" {'Exiting program...'
                        sleep 2
                        cls
                        $run = 0
                        }

                    default {''
                        "Feel free to change your mind any time..."
                        sleep 2
                        }
        
                }
        }
        
    # scrub user input variables for re-run
    $zen = ""
    $ans = ""
    
    }
}

## Comment this part out if running as stand-alone script##
if ($run -eq 0) {
    exit
}
