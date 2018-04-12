# Misc

Now, interestingly at the time I started this I was unaware of any modules out in the wild which came with a built-in Plaster template.  Until Michael Lombari released his Documentarian in mid to late March.  If you want to know more about Documentation as a User Experience then I encourage you to visit Michael's session tomorrow at 2PM.

I saw his lightening demo last year about the 3 different types of documentation and actually found it to be pretty interesting.

```powershell
Find-Module -Name Documentarian | Install-Module -Scope CurrentUser

# Or to walk your modules directory.
Get-PlasterTemplate -IncludeInstalledModules
```

Looking at the template in Documentarian we can see the same fields as before and just note that the template path reflects that it found this template while walking through our `$env:PSModulePath` modules.

```text
Title        : Documentarian
Author       :
Version      : 0.2.0
Description  : Scaffolds the files required for GitBook Documentation.
Tags         : Documentation
TemplatePath : C:\Users\pleaur\Documents\PowerShell\Modules\documentarian\0.10.0\GitBook
```

## Remaining Notes

Places where Plaster falls short is in its discoverability of templates.  Unlike modules or scripts, there is no central repository for plaster templates yet.