#visual-studio-builddir
Visual Studio property sheet to use a separate build output directory.

The `builddir.props` property sheet defines a new macro, `$(BuildDir)`, set to `$(SolutionDir)build\$(Configuration)\` by default.
All intermediate and final output files from the compilation will be placed under this directory.

The `package.xml` file makes it possible to modify this macro on a per project and configuration basis by adding an option in the Property Pages of the project.
You can find it under: Configuration Properties > NuGet Dependencies > builddir > Build Directory

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
|           static.pdb
│
└───Release/
		...
```

##Installation
You'll probably want to use this `$(BuildDir)` in all the projects in your solution, and there are three easy ways of accomplishing this:

###Nuget (recommended)
Run the following in the [Package Manager Console](http://docs.nuget.org/docs/start-here/using-the-package-manager-console):  
`get-project -all | install-package builddir`

###Git submodule
Add this project as a submodule from command line:  
`git submodule add https://github.com/blole/visual-studio-builddir`  
and then follow the manual instructions.

###Manual
Download the builddir.props and package.xml files and then add builddir.props to all your projects in Visual Studio:  
View > Property Manager > select all your projects > right-click > Add Existing Property Sheet > select builddir.props
