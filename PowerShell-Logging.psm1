#Requires -Version 5.1

$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
$ModuleName = $ExecutionContext.SessionState.Module
Write-Verbose -Message "Loading module $ModuleName"

#"Private" Variable to store user configuration settings
Write-Verbose -message "Creating Module Viarables"
$PSLogEventSession = @{
    LogFolderPath = $null
    LogFileName   = $null
}

#dot source public and private functions, export public functions
try {
    foreach ($Scope in 'Public', 'Private') {
        Get-ChildItem (Join-Path -Path $ScriptPath -ChildPath $Scope) -Filter *.ps1 | ForEach-Object {
            . $_.FullName
            if ($Scope -eq 'Public') {
                Export-ModuleMember -Function $_.BaseName -ErrorAction Stop
            }
        }
    }
}
catch {
    Write-Error ("{0}: {1}" -f $_.BaseName, $_.Exception.Message)
    exit 1
}