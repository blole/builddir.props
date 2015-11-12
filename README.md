#builddir.props
Visual Studio property sheet to use a separate build output directory.

This property sheet defines a new user macro, `$(BuildDir)`, set to `$(SolutionDir)build/$(Configuration)/` by default.
All intermediate and final output files from the compilation will be placed under this directory.

##Example output directory structure
Using the default `$(BuildDir)`, when compiling a solution with three projects:

Project Name | Configuration Type
-------------|-------------------
app          | Application (.exe)
dynamic      | Dynamic library (.dll)
static       | Static library (.lib)

The output would be:

```
build/
├───Debug/
│   ├───bin/
|   │       app.exe
|   │       app.pdb
|   │       dynamic.dll
|   │       dynamic.pdb
|	|
|   ├───intermediate/
|   │   ├───app/
|   │   |       *.obj
|   │   ├───dynamic/
|   │   |       *.obj
|   │   └───static/
|   │           *.obj
|	|
|   └───lib/
|           dynamic.exp
|           dynamic.lib
|           static.lib
│
└───Release/
		...
```

##Installation
You probably want to use this `$(BuildDir)` in all projects in your solution.
There are three ways of accomplishing this:

###Nuget (recommended)
Run the following in the [Package Manager Console](http://docs.nuget.org/docs/start-here/using-the-package-manager-console):  
`get-project -all | install-package builddir.props`

###Git submodule
Add this project as a submodule from command line:  
`git submodule add https://github.com/blole/builddir.props`  
and then follow the manual instructions.

###Manual
Download the builddir.props file and then add it to all your projects in Visual Studio:  
View > Property Manager > select all your projects > right-click > Add Existing Property Sheet > select builddir.props
