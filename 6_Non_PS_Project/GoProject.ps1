##############
# Go Project #
##############
Clear-Host; Push-Location -Path $demoPath

# Time to scaffold a non-PowerShell project.
# This is my *extremely* basic Go project example.
Get-PlasterTemplate -Path '.\6_Non_PS_Project\plaster-templates\NewGoLangProject\'

# Invoke Plaster to run the template.
# Notice here we are going to be passing "ProjectName" which is a parameter in our manifest.
# Despite the text logo being really cool, let's skip that this time around.
Invoke-Plaster -TemplatePath '.\6_Non_PS_Project\plaster-templates\NewGoLangProject\' -DestinationPath '.\Demo\Output' -ProjectName HelloSummit -NoLogo

# Running Go now, I have installed Go / GoLang on my machine, trust that Go is installed and my Go workspace is setup correctly.
# Using "go run" we can automatically compile and run our Go application and test it out.  This is totally independent of PowerShell or anything in the .Net world!
go run .\Demo\Output\HelloSummit\HelloSummit.go