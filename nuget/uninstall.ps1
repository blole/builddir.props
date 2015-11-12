param($installPath, $toolsPath, $package, $project)
$propertySheetPath = "$toolsPath\..\build\builddir.props"


$configs = $project.Properties.Item("Configurations").Object
foreach ($config in $configs)
{
	$propertySheet = $config.AddPropertySheet($propertySheetPath)
	$config.RemovePropertySheet($propertySheet)
}
