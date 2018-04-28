function Start-Demo
{
    [CmdletBinding()]
    param
    (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Path to demo root dir.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )
    process
    {
        try
        {
            Test-Path -Path $Path
            New-Variable -Scope Global -Name demoPath -Value $Path -Force -ErrorAction SilentlyContinue
            Push-Location -Path $demoPath
        }
        catch
        {
            Write-Error -Message $_
            throw 'Could not initialize demo path and global demo variable.'
        }

        #Create the directories.
        New-Item -Path .\Demo -ItemType Directory -Name Output -Force
        New-Item -Path .\Demo -ItemType Directory -Name 'plaster-templates' -Force

        if (Test-Path -Path '.\plaster-xml.code-snippets')
        {
            Push-Location -Path $demoPath
            Copy-Item -Path '.\plaster-xml.code-snippets' -Destination "$Env:USERPROFILE\AppData\Roaming\Code\User\snippets" -Force
            Pop-Location
            Get-ChildItem -Path "$Env:USERPROFILE\AppData\Roaming\Code\User\snippets\plaster-xml.code-snippets"
        }
        else
        {
            Write-Warning -Message 'Missing plaster-xml.code-snippets, cannot copy.'
        }

        if (Test-Path -Path "$($Env:USERPROFILE)\Desktop\ZoomIt.exe")
        {
            Write-Output -InputObject 'ZoomIt Present...'
        }
        else
        {
            Write-Output -InputObject 'Grabbing ZoomIt...'
            Push-Location -Path "$($Env:USERPROFILE)\Desktop\"
            Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/ZoomIt.zip' -OutFile 'ZoomIt.zip'
            Expand-Archive -Path ".\ZoomIt.zip" -DestinationPath .
            Remove-Item -Path '.\ZoomIt.zip'
            Start-Process -FilePath '.\ZoomIt.exe'
            Pop-Location
        }

        if (-not (Get-Module -Name Plaster -ListAvailable))
        {
            Install-Module -Name Plaster -Scope CurrentUser
        }
        if (-not (Get-Module -Name Pester -ListAvailable))
        {
            Install-Module -Name Pester -Scope CurrentUser
        }
    }
}
Start-Demo -Path "$Env:USERPROFILE\Desktop\code\git\PSSummit2018-Plaster"
#Clear-Host