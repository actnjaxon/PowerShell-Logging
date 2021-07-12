function Set-PSLogEventFolder {
    [cmdletbinding()]
    param(
        # The Folder Path to where you want your log file stored
        [Parameter(Mandatory = $True)]
        [String]
        $LogFolder
    )

    if (Test-Path $LogFolder) {
        $PSLogEventSession.LogFolderPath = $LogFolder
    }
    Else {
        Throw "Log Folder $LogFolder does not exist: Check the path entered"
    }
   
}