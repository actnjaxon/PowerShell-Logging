function Set-PSLogEventFile {
    [cmdletbinding()]
    param(
        # The log file name you want to use
        [Parameter(Mandatory = $True)]
        [String]
        $LogFile
    )

    $PSLogEventSession.LogFileName = $LogFile
   
}