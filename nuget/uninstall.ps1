param($installPath, $toolsPath, $package, $project)
$pspkg = $(ls "$installPath\..\manage-property-sheets*")[-1]
. "$pspkg\tools\manage-property-sheets.ps1"

Remove-Property-Sheet $project "$toolsPath\builddir.props"
