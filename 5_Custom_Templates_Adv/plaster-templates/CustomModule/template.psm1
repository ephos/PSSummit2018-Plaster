#Unblock files.
Get-ChildItem -Path $PSScriptRoot -Recurse | Unblock-File

<%
    if ($PLASTER_PARAM_ModuleFolders -contains 'Classes')
    {
@"
#Add the classes required for the module.
Get-ChildItem -Path $PSScriptRoot\Classes\*.cs | ForEach-Object {
    try 
    {
        Add-Type -Path $_.FullName -ErrorAction Stop
    }
    catch
    {
        throw
    }
}
"@
    }
%>

#Dot source private functions.
Get-ChildItem -Path $PSScriptRoot\Functions\Private\*.ps1 | Foreach-Object { . $_.FullName }
#Dot source public functions.
Get-ChildItem -Path $PSScriptRoot\Functions\Public\*.ps1 | Foreach-Object { . $_.FullName }


