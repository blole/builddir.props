param($installPath, $toolsPath, $package, $project)
$DTE.ExecuteCommand("File.SaveAll")
$projectMSBuild = [Microsoft.Build.Construction.ProjectRootElement]::Open($project.FullName)

# get relative path to builddir.props
Push-Location
Set-Location $project.Properties.Item("ProjectDirectory").Value
$builddirRelPath = Resolve-Path -Relative "$toolsPath\builddir.props"
Pop-Location

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
