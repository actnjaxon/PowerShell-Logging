function Get-PSLogEventFile {
    [cmdletbinding()]
    param()

    $output = $PSLogEventSession.Clone()
    $output.LogFileName

}