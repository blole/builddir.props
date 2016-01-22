param($installPath, $toolsPath, $package, $project)
. $toolsPath\funcs.ps1

$projectName = $project.Name
$projectFullName = $project.FullName
$projectDir = $project.Properties.Item("ProjectDirectory").Value
$builddirRelPath = Relative-Path $projectDir "$toolsPath\builddir.props"


Select-Project $projectName
$dte.ExecuteCommand("Project.UnloadProject")
$projectMSBuild = [Microsoft.Build.Construction.ProjectRootElement]::Open($projectFullName)



# The goal is to add something like this to the projects' .vcxproj:
#
# <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
#+  <Import Project="..\packages\builddir.x.y.z\tools\builddir.props" Condition="exists('..\packages\builddir.x.y.z\tools\builddir.props')" />
#   ...
# </ImportGroup>

foreach ($propertySheetGroup in $projectMSBuild.ImportGroups | where {$_.Label -eq "PropertySheets"})
{
	$import = $projectMSBuild.CreateImportElement($builddirRelPath);
	$import.Condition = "exists('"+$builddirRelPath+"')"
	$propertySheetGroup.PrependChild($import)
}



$projectMSBuild.Save()
Select-Project $projectName
$dte.ExecuteCommand("Project.ReloadProject")
