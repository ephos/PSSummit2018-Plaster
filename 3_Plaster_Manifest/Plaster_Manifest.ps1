####################
# Plaster Manifest #
####################
Clear-Host; Push-Location -Path $demoPath

# Open the built in module template in code.
Get-PlasterTemplate
# We can see the path in the metadata, lets open it up and take a look.
code $env:USERPROFILE\Documents\PowerShell\Modules\Plaster\1.1.3\Templates\NewPowerShellScriptModule

# Plaster Manifest Parameters are Dynamically Invoke-Plaster function parameters.
# I've found this to sometimes be flakey but cool when it works...
Invoke-Plaster #Tab through the parameters to see there are only the TemplatePath, DestinationPath, NoLogo, Force.
Invoke-Plaster -TemplatePath "$Env:USERPROFILE\Documents\PowerShell\Modules\Plaster\1.1.3\Templates\NewPowerShellScriptModule"
# Tab through and see the new parameters which match the PlasterManifest files parameters.

# Manifest Variables and Usage
Get-Help -Name about_Plaster_CreatingAManifest.help -ShowWindow
