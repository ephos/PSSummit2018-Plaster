# Creating PowerShell Projects and More with Plaster

**A.K.A. Lets Get Plastered!**

PowerShell + DevOps Global Summit 2018

## Intro

Hi welcome to "Creating PowerShell Projects and More with Plaster"!

Now for a quick intro.  I'm Rob, you may see me now and then **Github** or **/r/PowerShell** as Ephos.  Cool.  Thats the intro.  Let's jump into the presentation!

- Quick note about session name.

## The Problem

I am starting by making a broad assumption everyone here has in some way shape or form written and/or currently writing PowerShell modules.

A Problem I found myself having is that every time I started a new PowerShell module project, I was spending "*wasting*" a ton of time just setting up the module itself, items like the following.

- PSD1 / Manifest
- PSM1 / Root Module File
- Function file directories (because I am pro dot sourcing *(yes even though I lose a few nano seconds on import...)*)
- Pester tests directories, initial meta test files themselves
- Sometimes editor workspace settings for a project (.vscode) or a .gitignore to ignore editor workspace settings directories!

The worst part about this setup?  It was copy and paste, and I made A LOT of mistakes. (Like a lot, a lot) before getting it right.

At this point I haven't even begun writing any functions, I've spun my wheels on setup alone.

So what did I do?...  I started writing my own scaffolding code for my PowerShell projects... Then realized shortly after there was Plaster and realized I just wasted time re-inventing the wheel, oops. **¯\\_(ツ)_/¯**

Before we jump in, just a show of hands.  How many people have heard of Plaster?
How many people have used it?

The most basic explanation is that Plaster is a PowerShell module which can be used to scaffold other PowerShell projects.
If anyone has heard of Yeoman or used the .Net Core tooling `dotnet new` then you may already be familiar with the concept.

The idea is that you have templates for projects, in this case lets say a PowerShell module, and you fill in the blanks on these templates to create a module with no copy paste.

The madness doesn't need to stop at the module, templates can extend to literally anything you can dream up.  You can even use Plaster templates to scaffold Plaster templates.  _*This is where an exhibit meme would go*_

Lets dive into the demo...  Or as I like to say.

**Lets. Get. Plastered!**

## Links

[Summit](https://powershelldevopsglobalsummit2018.sched.com/event/CrVY/creating-powershell-projects-and-more-with-plaster#)
[Summit Alternate Link](http://sched.co/CrVY)
[Github](https://github.com/ephos/PSSummit2018-Plaster)