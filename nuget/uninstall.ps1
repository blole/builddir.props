param($installPath, $toolsPath, $package, $project)
$DTE.ExecuteCommand("File.SaveAll")
$projectMSBuild = [Microsoft.Build.Construction.ProjectRootElement]::Open($project.FullName)

foreach ($import in $projectMSBuild.Imports | where {$_.Project.endsWith("\builddir.props")})
{
	$import.Parent.RemoveChild($import)
}

$projectMSBuild.Save()
