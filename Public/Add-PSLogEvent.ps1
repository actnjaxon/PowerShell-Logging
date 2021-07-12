Function Add-PSLogEvent {
    [cmdletbinding()]
    param(
        # Switch for identfying erorr events. Unfortunatly error is a protected variable/parameter in powershell XD. This is the default
        [Parameter(AttributeValues)]
        [Switch]
        $Critical,
        
        # Switch for identfying Warning Events to add to the log
        [Parameter(AttributeValues)]
        [Switch]
        $Warning,

        # Parameter help description
        [Parameter(AttributeValues)]
        [Switch]
        $Info,

        # Identity of the process that generated an event
        [Parameter(Mandatory = $true)]
        [String]
        $Identity,
        
        # Log folder path
        [Parameter(Mandatory = $false)]
        [String]
        $LogFolder = $(Get-PSLogEventFolder),

        # Log File name
        [Parameter(Mandatory = $false)]
        [String]
        $LogFile = $(Get-PSLogEventFile),

        # Custom Error/Warning/Info message to be written to the log
        [Parameter(Mandatory = $true)]
        [String]
        $EventMessage,
        
        # PSError trace details so you can log those aswell as generic script errors
        [Parameter(ParameterSetName = "Error",
            Mandatory = $true)]
        [System.Management.Automation.ErrorRecord[]]
        $ErrorDetails
    )

    if ($ErrorDetails) {
        $EventObj = [PSCustomObject][Ordered]@{
            TimeStamp    = (Get-Date -Format "MM-dd-yyyy HH:mm:ss.ff K")
            Identity     = $Identity
            EventType    = $null
            EventMessage = $EventMessage
            ErrorDetails = $ErrorDetails
        }
    }
    else {
        $EventObj = [PSCustomObject][Ordered]@{
            TimeStamp    = (Get-Date -Format "MM-dd-yyyy HH:mm:ss.ff K")
            Identity     = $Identity
            EventType    = $null
            EventMessage = $EventMessage
            ErrorDetails = $null
        }
    }

    if ($Warning) {
        $EventObj.EventType = "Warning"
    }
    elseif ($info) {
        $EventObj.EventType = "Info"
    }
    else {
        $EventObj.EventType = "Error"
    }

    WritePSLogEvent -LogFolder -LogFile -EventObj
}