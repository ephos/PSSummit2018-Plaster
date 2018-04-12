# Create a Module Plaster Template

Lets create our own module project template.  I like to dot source my functions and I want to have some more stuff included from the start.

To begin with, we'll need to start with a plasterManifest.xml file.

Creating one of these is a lot like creating a PowerShell module's manifest file and if I remember correctly there was even a function to help us do that.

```powershell
Get-Command -Module Plaster
```

Yep, `New-PlasterManifest` is our guy here.  Lets give it a try.

```powershell
# Lets create a custom Plaster template, we need to start with a manifest.
New-Item -Path .\Demo\plaster-templates\ -Name MyCustomModule -ItemType Directory -Force
Set-Location -Path '.\Demo\plaster-templates\MyCustomModule\'
# For some reason -Path seems to throw an exception so we'll just go into the directory to create the manifest.
New-PlasterManifest -TemplateName NewPowerShellModule -TemplateType Project -TemplateVersion 0.1.0 -Description "Custom Module" -Tags Module,Rob
```

Let's take a look a our new manifest.

```powershell
Set-Location -Path ..\..\..\
# Xml is generated for you!
code '.\Demo\plaster-templates\MyCustomModule\plasterManifest.xml'
```

It's pretty bare!  I know, writing XML kind of sucks.  You could always copy and paste from another manifest.

Alternatively, I've created some VSCode snippets which will be included in this project for you to use to hit the common manifest items!

```powershell
# Xml still kind of sucks, this should help!
code '.\4_Custom_Template\plaster-xml.code-snippets'
code '.\4_Custom_Template\plaster-templates\CustomModule\PlasterManifest.xml' #Test out some snippets.
```

We can validate our new Plaster template.  If you remember earlier when we looked at the included functions in Plaster, there was a function that'll do this for us!

```powershell
# One of our 4 included functions in this module should help!
Get-Command -Module Plaster
# Let's test out the manifest.
Test-PlasterManifest -Path '.\Demo\plaster-templates\MyCustomModule\plasterManifest.xml'
# Lets take a look at our new custom PowerShell module Plaster template.
Get-PlasterTemplate -Path '.\Demo\plaster-templates\MyCustomModule\'
```

So much like a cooking show, even with the snippets I have added watching me type out XML would be pretty lame for all of us.
I'm going to take the finished ham out of the oven... I mean Plaster template.

Lets take a look at what this Plaster manifest is going to do.

```powershell
code '.\4_Custom_Template\plaster-templates\CustomModule\plasterManifest.xml'
```

Let's take it for a spin.

```powershell
# Invoke-Plaster Custom Module v1.
Invoke-Plaster -TemplatePath '.\4_Custom_Template\plaster-templates\CustomModule' -DestinationPath '.\Demo\Output\'
```

Let's add a function to our new module.
Don't forget to export it!

```powershell
Import-Module -Name Pester -Force
Invoke-Pester -Path .\Demo\Output\Module1\tests\
Import-Module -Path .\Demo\Output\Module1\src\Module1.psd1
```