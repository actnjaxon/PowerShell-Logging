function Get-PSLogEventFolder {
    [cmdletbinding()]
    param()

    $output = $PSLogEventSession.Clone()
    $output.LogFolderPath

}