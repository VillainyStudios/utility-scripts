# Menu
 
$run = 1
$choice = ""
 
while ($run -eq 1) {
    while (($choice -ne (1..10)) -and $choice -ne "q") {
        cls
        'Welcome'
        ''
        'Please choose an option below'
        '-----------------------------'
        ''
        '1. Task Manager Toggler'
        '2. Clipboard Logger'
        '3. File Scraper'
        #'4. (unimplemented)'
        #'5. (unimplemented)'
        #'6. (unimplemented)'
        #'7. (unimplemented)'
        #'8. (unimplemented)'
        #'9. (unimplemented)'
        #''
        #'N. Next Page'
        ''
        'Q. Quit'
        
        $choice = read-host
        
        switch ($choice) {
            1 {cmd /c start powershell -NoExit -Command {$Host.UI.RawUI.WindowTitle = "Toggler"}
            2 {}
            3 {}
            4 {}
            5 {}
            6 {}
            7 {}
            8 {}
            9 {}
          "q" {cls; 'Exiting...'; sleep 2; $run = 0; cls}
            
            
            
        }
        
        
    } 
    
}
