#######################
# Install and Explore #
#######################
Clear-Host; Push-Location -Path $demoPath

# Install Plaster (Let't skip this, something, something, conference wifi...)
Find-Module -Name Plaster | Install-Module -Scope CurrentUser

# Familiarize yourself with the available functions.
Get-Command -Module Plaster

# Take a look at what templates come packaged in the box.
Get-PlasterTemplate

# Alternatively if you have a directory which houses some templates you already created you can specify the path parameter set.
Get-PlasterTemplate -Path "$Env:USERPROFILE\Desktop\code\git\PlasterTemplates\" -Recurse