#
# Module manifest for module 'PSRemoteRegistry'
#
# Generated by: Shay Levy
#
# Generated on: 12/15/2009
#

@{ 

# Script module or binary module file associated with this manifest
ModuleToProcess = 'PSRemoteRegistry.psm1'

# Version number of this module.
ModuleVersion = '2.0.0.0'

# ID used to uniquely identify this module
GUID = '8ac26adc-b3bd-4f30-b25f-8984a6b4000a'

# Author of this module
Author = 'Shay Levy'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2009 Shay Levy. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This module contains functions to create, modify or delete registry subkeys and values on local or remote computers.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '2.0'

# Name of the Windows PowerShell host required by this module
PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = '2.0.50727'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = ''

# Processor architecture (None, X86, Amd64, IA64) required by this module
ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @('PSFanatic.PSRemoteRegistry.Format.ps1xml')

# Modules to import as nested modules of the module specified in ModuleToProcess
NestedModules = @()

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
ModuleList = @()

# List of all files packaged with this module
FileList = @('PSRemoteRegistry.psd1','PSRemoteRegistry.psm1','PSFanatic.PSRemoteRegistry.Format.ps1xml','about_PSRemoteRegistry_Module.help.txt')

# Private data to pass to the module specified in ModuleToProcess
PrivateData = ''
}

