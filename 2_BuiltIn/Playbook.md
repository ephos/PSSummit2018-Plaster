# Built In Plaster

Lets give the built-in templates a go to get a feel for Plaster.

Lets create a module right now!

In this demo project I have created a folder, un-originally named... Demo!

Within it I have the directory where we'll be checking our work.  If you clone this project from Github you should be able to use the `DemoSetup.ps1` and `DemoTearDown.ps1` to follow through it.

We're going to create a new module, lets call it **PSAwesome** because its awesome, and stuff...

Lets setup our destination directory where we want this project to go, in this case I am going to call it PSAwesome since that is going to be the name of our module project.

```powershell
#Create a destination location for the module, this will be an empty directory until we Invoke-Plaster.
$destinationPath = New-Item -Path .\Demo\Output -itemType Directory -Name PSAwesome
$destinationPath
```

When you run Pester you have very little information to actually provide the `Invoke-Plaster` function itself.  The meat of it is really in the templates which we'll dive into later, the function itself really mainly needs a `-TemplatePath` and an `-DestinationPath`

Now that we have an output path we can Invoke-Plaster to create our module there.

Lets take a look at our built in module template again.

Get-PlasterTemplate doesn't really have a nice way to discover but we can just use `Where-Object` to look for the template that contained the tag "module".

```powershell
#Check the installed templates so we can select one.  Lets use Where-Object to get the one we want.
Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains 'Module'}

#Store it in a var so we don't need worry about messing up the path.
$template = Get-PlasterTemplate | Where-Object -FilterScript {$_.Tags -contains 'Module'}
$template.TemplatePath
```

You'll notice I am storing these values into variables, that's because I am a terrible typist and will probably butcher things like the paths!

Let's fire this thing up now.

```powershell
#Invoke Plaster!
Invoke-Plaster -TemplatePath $template.TemplatePath -DestinationPath $destinationPath
```

_**Go through the setup**_

- Note worthy items
  - VSCode option, VSCode rocks!
  - Pester test setup is included, write Unit and Integration tests!

Now, this is a parameter called `-NoLogo` which I guess you *could* use.  I think the logo is cool, if you're running this programmatically I could see you not wanting to see it in your CI products logs... but it is really cool, and someone clearly took the time to make that ASCII logo.

Lets take a look at the output.

```powershell
#Take a look at the output
Get-ChildItem -Path .\Demo\Output\PSAwesome\
Get-ChildItem -Path .\Demo\Output\PSAwesome\test\
Get-Content -Path .\Demo\Output\PSAwesome\PSAwesome.psm1
Get-Content -Path .\Demo\Output\PSAwesome\PSAwesome.psd1
Get-Content -Path .\Demo\Output\PSAwesome\test\PSAwesome.Tests.ps1
```

We have a fresh new module here, with a very very simple Pester test to get us started, which more or less tests the module manifest file with `Test-ModuleManifest`

That's a significant time savings right?

We didn't have to type any of that boilerplate code, we didn't make any typos and we have a module ready to go.

We can now start the fun part of coding without worrying about the boring setup, lets add a function.

```powershell
#We can start adding functions now
code .\Demo\Output\PSAwesome\  #Go ahead and add a function in the .psm1 file.
```

Now that we've added a function lets give our new module a spin.  For the sake of the demo we're not going to worry about `$env:PSModulePath` and just import right from our working directory in the demo.

```powershell
#Lets import it (just from where it is, we won't worry about making sure its in a module path for this)
Import-Module .\Demo\Output\PSAwesome\PSAwesome.psd1
Get-Module -Name PSAwesome
Get-Command -Module PSAwesome
```

Pretty Awesome!  This works, but I demand more out of my module structures.  Anyone else here a fan of dot sourcing functions?  Or having public and private directories for functions?

Lets take a look at extending this further.