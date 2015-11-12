param($installPath, $toolsPath, $package, $project)
$propertySheetPath = "$toolsPath\..\build\builddir.props"


function MovePropertySheetFirst($config, $propertySheet)
{
	try
	{
		while ($True)
		{
			$config.MovePropertySheet($propertySheet, $False)
		}
	}
	catch [ArgumentException]
	{
	}
}


$configs = $project.Properties.Item("Configurations").Object
foreach ($config in $configs)
{
	$propertySheet = $config.AddPropertySheet($propertySheetPath)
	MovePropertySheetFirst $config $propertySheet
}
