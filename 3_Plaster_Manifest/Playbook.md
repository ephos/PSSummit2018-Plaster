# Plaster Manifest

Before we start building our own template, lets take a quick look at the anatomy of a template.  We can look at the one we just used.

```powershell
Get-PlasterTemplate
code 'C:\Users\username\Documents\PowerShell\Modules\Plaster\1.1.3\Templates\NewPowerShellScriptModule\'
```

The main thing you'll see is the manifest, this is the magic file that orchestrates most of this!

For anyone allergic to XML don't sweat this, the schema of the manifest is fairly simple and broken up into a few sections.
Metadata, Parameters and Content.

- metadata
- parameters
  - parameter - *The option category presented to the user, can have multiple choices*
    - choice - *The selectable option which will be used in the content section*
- content
  - newModuleManifest - *What drives the content of the module manifest (psd1) file*
  - file - *Creates a directory, or copies a file which is part of the template*
  - templatefile - *Use a file included in the template as a base and handles any tokenization*
  - requiremodule - *Used to define a dependent module that will be needed for this project, used mostly for Pester*

You can also have a `<message>` tag to output information to the user invoking the template.

So if we look at the top of the file you'll notice the metadata which is some of the data we see when we run `Get-PlasterTemplate`.

```xml
<metadata>
  <name>NewPowerShellScriptModule</name>
  <id>2a7c3f58-4a45-4d55-9b07-753ac7608114</id>
  <version>1.1.0</version>
  <title>New PowerShell Manifest Module</title>
  <description>Creates files for a simple, non-shared PowerShell script module.</description>
  <author>Plaster</author>
  <tags>Module, ScriptModule, ModuleManifest</tags>
</metadata>
```

You remember as we ran through the template we were prompted with a series of questions?  You'll see these options in our manifest within the `<Parameters>` tags.

```xml
<parameter name='Editor' type='choice' prompt='Select an editor for editor integration (or None):' default='1' store='text' >
  <choice label='&amp;None' help="No editor specified." value="None"/>
  <choice label='Visual Studio &amp;Code' help="Your editor is Visual Studio Code." value="VSCode"/>
</parameter>
```

There are 4 different types of parameters.

- Text - *Text input*
- Choice - *A single choice that can be selected from the options*
- MultiChoice - *Multiple choices can be selected*
- user-fullname and user-email - *These other types are similar to text except they will be pulled from the users .gitconfig file if one is present*

A parameter tag as a store option available.  Where you can optionally store parameter values on input to a location in your user profile, they will be stored in a *Name-Version-ID.clixml* file.  This will make the next run of Invoke-Plaster store these as defaults for subsequent runs.

A interesting note about Plaster parameters.  On the `Invoke-Plaster` function, and this literally blew my mind the first time I ran it.  The parameters in the manifest file will be converted into Invoke-Plaster's function parameters.

```powershell
Invoke-Plaster #Tab through the parameters to see there are only the TemplatePath, DestinationPath, NoLogo, Force etc
Invoke-Plaster -TemplatePath 'C:\Users\username\Documents\PowerShell\Modules\Plaster\1.1.3\Templates\NewPowerShellScriptModule' #Tab through and see the new parameters which match the PlasterManifest files parameters.
```

Parameter values can be referenced in Plaster by using `PLASTER_PARAM_ParameterName`.  In addition to parameters that you create, Plaster ships with some built-in variables like *PLASTER_DestinationPath*, *PLASTER_Year*, *PLASTER_Version*.  These are well documented in the help that ships with Plaster.

```powershell
Get-Help -Name about_Plaster_CreatingAManifest.help
```

The **content** section, which utilizes information passed in from the **parameter** section is responsible for the file layout/contents and structure of the module.
It can also be used for informational messages or validating module dependencies (like Pester).

Within content the 3 big players here are newModuleManifest, file, and templatefile.  Now a minute ago I mentioned how Parameter values are stored in variables in Plaster, and here you'll see why.

**newModuleManifest** is pretty straight forward and will be used to build and populate the module manifest file.

You can see the parameters referenced as variables here.  You'll need to use `${}` (dollar sign, curly brace) sub-expression syntax if referencing it in other text, otherwise if you just need the value you can reference it with a dollar sign!

```xml
<newModuleManifest destination='${PLASTER_PARAM_ModuleName}.psd1'
                    moduleVersion='$PLASTER_PARAM_Version'
                    rootModule='${PLASTER_PARAM_ModuleName}.psm1'
                    encoding='UTF8-NoBOM'
                    openInEditor="true"/>
```

**file** will be used to copy an included file in out Plaster template into the file module project.  In this case out PSM1 file will be copied, you can see when it does it will be named to out <ModuleName>.ps1.

```xml
<file source='Module.psm1' destination='${PLASTER_PARAM_ModuleName}.psm1' openInEditor="true"/>
```

Okay lets talk real quick about token replacement and template files, what the heck are those?  This is where Plaster starts to get pretty sweet!

**templateFile** is similar to file but a little more powerful in a sense that we can tokenize the files to use PowerShell logic inside them to really manipulate them.

Again still looking at our Plaster provided template we can see this happening with the Pester tests that it builds.  We see its using the source file `Module.T.ps1` and like file, when it gets copied to our destination it gets renamed to ModuleName.Tests.ps1.

```xml
<templateFile source='test\Module.T.ps1' destination='test\${PLASTER_PARAM_ModuleName}.Tests.ps1' />
```

If we look at the source file, we can see some tokenization action going down in it.

The first line of the Pester test is `$ModuleManifestName = '<%=$PLASTER_PARAM_ModuleName%>.psd1'`  When Plaster creates this file from the template it is actually going to take our user provided module name and insert it there!

Token replacement isn't limited to just referencing Plaster variables, like I mentioned before its actually possible to have PowerShell logic in these files.

When using a script block inside a template file it needs to be contained within `<% %>` and these delimiters need to be the first characters on the line (think of using them like using here-strings).

One thing to note... Can you token replace more than once in a template file?  Yes!!!

Lets move onto a Plaster template that isn't included with Plaster itself...