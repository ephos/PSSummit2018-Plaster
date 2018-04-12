$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Path $here -Parent

$modulePath = Join-Path -Path $root -ChildPath \src\
$moduleName = (Get-Item -Path "$modulePath\*.psd1").BaseName
$moduleManifest = Join-Path -Path $modulePath -ChildPath "$moduleName.psd1"
$functionsPublicPath = Join-Path -Path $modulePath -ChildPath 'Functions\Public'
$functionsPrivatePath = Join-Path -Path $modulePath -ChildPath 'Functions\Private'
$functionsPublic = Get-ChildItem -Path $functionsPublicPath -Filter *.ps1
$functionsAll = Get-ChildItem -Path $functionsPublicPath, $functionsPrivatePath -Exclude .gitkeep

Describe 'Module' {
	Context 'Manifest' {
		$script:manifest = $null

		It 'has a valid manifest' {
			{
				$script:manifest = Test-ModuleManifest -Path $moduleManifest -ErrorAction Stop -WarningAction SilentlyContinue
			} | Should Not throw
		}
		
		It 'has a valid name in the manifest' {
			$script:manifest.Name | Should Be $moduleName
		}

		It 'has a valid root module' {
			$script:manifest.RootModule | Should Be ($moduleName + ".psm1")
		}

		It 'has a valid version in the manifest' {
			$script:manifest.Version -as [Version] | Should Not BeNullOrEmpty
		}
	
		It 'has a valid description' {
			$script:manifest.Description | Should Not BeNullOrEmpty
		}

		It 'has a valid author' {
			$script:manifest.Author | Should Not BeNullOrEmpty
		}
	
		It 'has a valid guid' {
			{ 
				[guid]::Parse($script:manifest.Guid) 
			} | Should Not throw
		}
	
		It 'has a valid copyright' {
			$script:manifest.CopyRight | Should Not BeNullOrEmpty
		}

		It 'has the same number of exported public functions for function ps1 files' {
			($script:manifest.ExportedFunctions.GetEnumerator() | Measure-Object).Count | Should be ($functionsPublic | Measure-Object).Count
		}
	}

    foreach ($script:function in $functionsAll)
    {
        Context $script:function.BaseName {

            $script:functionContents = $null
            $script:psParserErrorOutput = $null
            $script:functionContents = Get-Content -Path $script:function.FullName

            It 'has no syntax errors'  {
                [System.Management.Automation.PSParser]::Tokenize($script:functionContents, [ref]$script:psParserErrorOutput)

                #(Measure-Object -InputObject $script:psParserErrorOutput).Count | Should Be 0
                ($script:psParserErrorOutput | Measure-Object).Count | Should Be 0

                Clear-Variable -Name psParserErrorOutput -Scope Script -Force
            }

            if (($Script:function.PSParentPath -split "\\" | Select-Object -Last 1) -eq 'Public' )
            {
                It 'is a public function and exported in the module manifest' {
                    $manifest.ExportedCommands.Keys.GetEnumerator() -contains $script:function.BaseName | Should be $true
                }
            }
        }
    }
}