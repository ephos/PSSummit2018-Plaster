######################################
# Extending Custom Templates Further #
######################################
Clear-Host; Push-Location -Path $demoPath

# Lets take a look at our module project.
Get-PlasterTemplate -Path '.\5_Custom_Templates_Adv\plaster-templates' -Recurse

# This has some more options, and will create an empty .cs file if we want for included classes.
# Rant about PowerShell classes in modules.

# Invoke-Plaster CustomModule v2 - Module2.
Invoke-Plaster -TemplatePath '.\5_Custom_Templates_Adv\plaster-templates\CustomModule' -DestinationPath '.\Demo\Output\'
