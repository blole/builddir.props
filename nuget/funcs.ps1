function Relative-Path {
	param([string]$from, [string]$to)
	Push-Location
	Set-Location "$from"
	Write-Output $(Resolve-Path -Relative "$to")
	Pop-Location
}

# from http://stackoverflow.com/questions/12292577/how-can-i-reload-a-visual-studio-project-thru-a-nuget-powershell-script
function Select-Project {
	param([string]$projectName)
	#following GUID = Constants.vsWindowKindSolutionExplorer
	#magic 1 = vsUISelectionType.vsUISelectionTypeSelect
	$shortpath = $dte.Solution.Properties.Item("Name").Value + "\" + $projectName
	$dte.Windows.Item("{3AE79031-E1BC-11D0-8F78-00A0C9110057}").Activate()
	$dte.ActiveWindow.Object.GetItem($shortpath).Select(1)
}
