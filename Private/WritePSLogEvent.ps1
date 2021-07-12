#Internal Module Function
Function WritePSLogEvent {
    [cmdletbinding()]
    param(
        # Log folder path
        [Parameter(Mandatory = $true)]
        [ParameterType]
        $LogFolder,

        # Log File name
        [Parameter(Mandatory = $true)]
        [ParameterType]
        $LogFile,

        # Event Object created by add-PSLogEvent
        [Parameter(Mandatory = $true)]
        [ParameterType]
        $EventObj
    )
    

    if (Test-Path $LogFolder) {
        $path = "$LogFolder" + '\' + "$LogFile"

        try {
            $eventObj | Export-Csv -NoTypeInformation -path $path -Append
        }
        catch {
            Throw "Error - Event Log File Not Valid: Configure a log file using the -LogFile parameter or use the Set-PSLogEventFolder cmdlet"
        }

    }
    else {
        Throw "Error - Event Log Folder Path Not Valid: Configure a folder path using Set-PSLogEventFolder cmdlet, or use the -LogFolder parameter in Add-PSLogEvent"
    }
    
}