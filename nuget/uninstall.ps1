param($installPath, $toolsPath, $package, $project)
. $toolsPath\funcs.ps1

$projectName = $project.Name
$projectFullName = $project.FullName


# Unloading and reloading projects does not seem to work in uninstall scripts:
#   "uninstall-package : Cannot access a disposed object."
# So I guess we'll just save then?
$project.Save()
$projectMSBuild = [Microsoft.Build.Construction.ProjectRootElement]::Open($projectFullName)



foreach ($import in $projectMSBuild.Imports | where {$_.Project.endsWith("\builddir.props")})
{
	$import.Parent.RemoveChild($import)
}












$projectMSBuild.Save()
