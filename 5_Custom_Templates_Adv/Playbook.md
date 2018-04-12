# Extending Custom Templates Further

Lets take a look at version 2 of our CustomModule Plaster template.

Again using the old cooking show oven trick, we have a version 2 plaster template ready to go!

```powershell
# Lets take a look at our module project.
Get-PlasterTemplate -Path '.\5_Custom_Templates_Adv\plaster-templates' -Recurse
```

We want to set the encoding in the module manifest when it gets created.  We've set the encoding to UTF8-noBOM.  In addition we've set this file to open in our editor when launched.  VSCode will honor this setting as well.

```xml
<newModuleManifest destination='${PLASTER_PARAM_ModuleName}\src\${PLASTER_PARAM_ModuleName}.psd1'
    moduleVersion='$PLASTER_PARAM_ModuleVersion'
    rootModule='${PLASTER_PARAM_ModuleName}.psm1'
    author='$PLASTER_PARAM_ModuleAuthor'
    description='$PLASTER_PARAM_ModuleDesc'
    companyName='$PLASTER_PARAM_ModuleCompanyName'
    powerShellVersion='$PLASTER_PARAM_ModulePowerShellVersion'
    encoding='UTF8-NoBOM'
    openInEditor="true"/>
```

We've added a new option to create a classes file for classes we want to include, these will be in *.cs files and we'll need to add them on module import using Add-Type.

Here is our PSM1

```powershell
<%
@"
class $PLASTER_PARAM_ModuleName
{

}
"@
%>
```

Here is our Plaster manifest code

```xml
<templateFile condition='$PLASTER_PARAM_ModuleFolders -contains "Classes"' source='template.cs.ps1' destination='${PLASTER_PARAM_ModuleName}\src\Classes\${PLASTER_PARAM_ModuleName}.cs' />
<file condition='$PLASTER_PARAM_ModuleFolders -contains "Binaries"' destination='${PLASTER_PARAM_ModuleName}\src\Binaries\' source='' />
```

Lets give it a run and go all out on the options.

```powershell
# Invoke-Plaster Custom Module v2.
Invoke-Plaster -TemplatePath '.\5_Custom_Templates_Adv\plaster-templates\CustomModule' -DestinationPath '.\Demo\Output\'
```