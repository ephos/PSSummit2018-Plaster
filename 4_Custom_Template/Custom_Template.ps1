###################################
#Create a Module Plaster Template #
###################################
Clear-Host; Push-Location -Path $demoPath

# We need to start with a Plaster manifest.
# There is a very good chance one of these functions is what we need... (HINT: New-PlasterManifest) 
Get-Command -Module Plaster

########################################################
# [Quirk / Rob Annoyance #2] New-PlasterManifest Issue #
########################################################
# Update April 11, 2018: After my session I was informed that it will create the directory automatically, so creating one ahead of time is why we see that error.  I still need to try this, and it still feels a little buggy to me as I think it should be able to... A. Handle this scenario or possible use -Force, B. At least throw a better error out saying "Directory is stil there yo!"
# Lets create a place to build our new Plaster template.
New-Item -Path .\Demo\plaster-templates\ -Name MyCustomModule -ItemType Directory -Force

# For some reason -Path seems to throw an exception so we'll just go into the directory to create the manifest.
# Here comes the error!!!  (I've tried various path)
New-PlasterManifest -TemplateName NewPowerShellModule -TemplateType Project -TemplateVersion 0.1.0 -Description "Custom Module" -Tags Module, Rob -Path '.\Demo\plaster-templates\MyCustomModule' 

# Not ideal but this works :(
Set-Location -Path '.\Demo\plaster-templates\MyCustomModule\'
New-PlasterManifest -TemplateName NewPowerShellModule -TemplateType Project -TemplateVersion 0.1.0 -Description "Custom Module" -Tags Module, Rob

# Xml is generated for you!
code .\plasterManifest.xml
Set-Location -Path ..\..\..\

# Xml still kind of sucks, this should help!
code '.\4_Custom_Template\plaster-xml.code-snippets'

# Lets take a look at our new custom PowerShell module Plaster template.
Get-PlasterTemplate -Path '.\4_Custom_Template\plaster-templates' -Recurse

################################################################################
# Watching someone write XML live is probably consider cruel and unusual...    #
# ...So through some cooking show magic, we have a completed plaster manifest! #
################################################################################

# Invoke-Plaster CustomModule v1 - Module1.
Invoke-Plaster -TemplatePath '.\4_Custom_Template\plaster-templates\CustomModule' -DestinationPath '.\Demo\Output\'

#Lets add a function.

# Its usable
Import-Module -Name Pester -Force
Invoke-Pester -Path .\Demo\Output\Module1\tests\
Import-Module .\Demo\Output\Module1\src\Module1.psd1
Get-Command -Module Module1