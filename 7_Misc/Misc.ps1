########
# Misc #
########
Clear-Host; Push-Location -Path $demoPath

# Documentarian (Michael Lombari's template!)
Find-Module -Name Documentarian | Install-Module -Scope CurrentUser

# Or to walk your modules directory.
Get-PlasterTemplate -IncludeInstalledModules