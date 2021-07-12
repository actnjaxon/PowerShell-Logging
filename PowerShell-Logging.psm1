#Requires -Version 5.1

Write-Verbose -message "Creating Module Viarables"
$PSLogEventSession = [ordered]@{
    LogFolderPath = $ENV:TEMP
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