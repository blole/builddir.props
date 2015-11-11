#builddir.props
Visual Studio property sheet to use a separate build output directory.

This property sheet defines a new user macro, `$(BuildDir)`, set to `$(SolutionDir)/build/$(Configuration)/` by default.
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
* Add this project as a submodule:  
`git submodule add https://github.com/blole/builddir.props`  
or simply download the builddir.props file.
* Add builddir.props to all your projects in Visual Studio:  
View > Property Manager > Right-click your project > Add Existing Property Sheet > select builddir.props

Now it'll build into `build/`
