##########################
# Built in Plaster Usage #
##########################
Clear-Host; Push-Location -Path $demoPath

# Create a destination location for the module, this will be an empty directory until we Invoke-Plaster.
# We'll call our new module PSAwesome!
# You could just as easily create module projects in a $PSModulePath location.
$destinationPath = New-Item -Path .\Demo\Output -ItemType Directory -Name PSAwesome
$destinationPath

# Check the installed templates so we can select one.  Lets use Where-Object to get the one we want.
# [Quirk / Rob Annoyance #1] Discoverability for Plaster could be a bit better, but we at least have some options.
Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains 'Module'}

# Store it in a var so we don't need worry about messing up the path.
$template = Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains 'Module'}
$template.TemplatePath

# Invoke Plaster!
Invoke-Plaster -TemplatePath $template.TemplatePath -DestinationPath $destinationPath

# Take a look at the output.  We can also start adding functions now!
code .\Demo\Output\PSAwesome\ #Go ahead and add a function in the .psm1 file.

#Lets import it (just from where it is, we won't worry about making sure its in a module path for this)
Import-Module .\Demo\Output\PSAwesome\PSAwesome.psd1
Get-Module -Name PSAwesome
Get-Command -Module PSAwesome

# We can run the Pester tests as well!
Import-Module -Name Pester
Invoke-Pester .\Demo\Output\PSAwesome\test

