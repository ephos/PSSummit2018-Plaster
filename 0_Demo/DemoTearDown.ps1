# Teardown

function Stop-Demo 
{
    [CmdletBinding()]
    param
    ()
    process
    {
        # Stop ZoomIt
        Get-Process -Name 'ZoomIt*' | Stop-Process -Force -ErrorAction SilentlyContinue

        # Remove the demo directory.
        Remove-Item -Path .\Demo -Recurse -Force -ErrorAction SilentlyContinue

        # Remove Snippets.
        Remove-Item -Path "$($env:UserProfile)\AppData\Roaming\Code\User\snippets\plaster-xml.code-snippets" -ErrorAction SilentlyContinue

        # Uninstall Plaster.
        Remove-Module -Name Plaster -Force -ErrorAction SilentlyContinue
        Uninstall-Module -Name Plaster -Force -ErrorAction SilentlyContinue
    }
}
Stop-Demo