# Start Chrome with Clarin webpage
Start-Process "chrome.exe" -ArgumentList "https://www.clarin.com" -WindowStyle Maximized

# Wait for Chrome to open
Start-Sleep -Seconds 5

# Find the Chrome window
$chromeWindow = Get-Process | Where-Object {$_.MainWindowTitle -like "*Clarin*"}

# Set the new size
$newWidth = 400
$newHeight = 600

# Set the window to stay on top and resize it
$chromeWindow.MainWindowHandle | ForEach-Object {
    $user32 = Add-Type -Name User32 -Namespace Win32 -PassThru -MemberDefinition @"
        [DllImport("user32.dll")]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
        public const uint SWP_SHOWWINDOW = 0x0040;
        public const uint SWP_NOZORDER = 0x0004;
        public const uint SWP_NOMOVE = 0x0002;
        public const uint SWP_NOOWNERZORDER = 0x0200;
        public const uint SWP_FRAMECHANGED = 0x0020;
"@
    [Win32.User32]::SetWindowPos($_, [Win32.User32]::HWND_TOPMOST, 0, 0, $newWidth, $newHeight, [Win32.User32]::SWP_NOZORDER -bor [Win32.User32]::SWP_SHOWWINDOW -bor [Win32.User32]::SWP_NOMOVE -bor [Win32.User32]::SWP_NOOWNERZORDER -bor [Win32.User32]::SWP_FRAMECHANGED)
}
