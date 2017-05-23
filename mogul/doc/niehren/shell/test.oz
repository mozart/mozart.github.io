declare URIs = ['x-ozlib://niehren/shell/short-path.ozf'
		'x-ozlib://niehren/shell/URI.ozf'
		'x-ozlib://base/inspector.ozf'
		'x-ozlib://niehren/shell/shell.ozf'
		'x-ozlib://niehren/shell/file.ozf'
	       ]
declare Mods = {Module.link URIs}
declare [ShortPath URI Inspector Shell File] = Mods

declare Inspect = Inspector.inspect %Browser.browse %

declare FileName = {URI.localize 'x-ozlib://niehren'}
{Inspect filename#FileName}
declare ExistsFile = {File.exists FileName}
{Inspect 'exists file'#ExistsFile#'('#FileName#')'}
declare FileNameHi ='/home/hi' 
declare ExistsHi   = {File.exists FileNameHi}
{Inspect 'exists file'#ExistsHi#'('#FileNameHi#')'}

declare ShortName = {ShortPath.convert FileName}
{Inspect shortname#ShortName}


declare Echo = {Shell.execute echo unit(args:['hi'])}
{Inspect echo#Echo}

/*
declare  DaVinciExe = {Shell.execute which unit(args:['daVinci.exe'])}
{Inspect {File.exists DaVinciExe#'.exe'}}
{Inspect 'DaVinciExe'#DaVinciExe}

declare DaVinciExeShort = {ShortPath.convert DaVinciExe}
{Inspect DaVinciExeShort}
{Inspect {OS.stat DaVinciExeShort}}
{Inspect {File.exists DaVinciExeShort}}
{Inspect 47|99|121|103|100|114|105|118|101|47|nil}
*/