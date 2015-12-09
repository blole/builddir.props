param($installPath, $toolsPath, $package, $project)
#TODO: unload and then reload project instead of saving
$project.Save()
$projectMSBuild = [Microsoft.Build.Construction.ProjectRootElement]::Open($project.FullName)

foreach ($import in $projectMSBuild.Imports | where {$_.Project.endsWith("\builddir.props")})
{
	$import.Parent.RemoveChild($import)
}
$projectMSBuild.Save()
