# Installation

I assume everyone has been installing modules for years but let's start totally fresh here and grab the latest plaster from the gallery.

```powershell
# Install Plaster
Find-Module -Name Plaster | Install-Module -Scope CurrentUser
```

Lets explore the functions that ship with plaster.

```powershell
# Familiarize yourself with the available functions.
Get-Command -Module Plaster
```

As you can see, we only have 4 functions, not bad, fairly small amount to learn.  Lets give some of them a test drive.

Lets start with Get-PlasterTemplate and see what templates ship with it.

```powershell
# Take a look at what templates come packaged in the box.
Get-PlasterTemplate
```

We see here we get 2 templates.  One for creating a PowerShell module and another for creating a PSScriptAnalyzer rule.

Lets just take a look at what the templates meta data is.

```text
Title        : New PowerShell Manifest Module
Author       : Plaster
Version      : 1.1.0
Description  : Creates files for a simple, non-shared PowerShell script module.
Tags         : {Module, ScriptModule, ModuleManifest}
TemplatePath : C:\Users\pleaur\Documents\PowerShell\Modules\plaster\1.1.3\Templates\NewPowerShellScriptModule
```

Most of these fields are self explanatory (like title, author etc. ), the notable things is that you can version these, tag them, and see where the physically reside on the file system.