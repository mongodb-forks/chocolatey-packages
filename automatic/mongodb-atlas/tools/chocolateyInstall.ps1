﻿$url         = 'https://github.com/mongodb/mongodb-atlas-cli/releases/download/atlascli/v1.34.0/mongodb-atlas-cli_1.34.0_windows_x86_64.msi'
$checksum    = '1b63accf0c4a498495e9d7843f8dfb4e0b4c09b0b206d555fe96594e3bab00b7'

$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = "$(Join-Path "$env:ProgramFiles` `(x86`)" 'MongoDB Atlas CLI')"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'msi' 
  url           = $url

  softwareName  = 'atlascli*'
  checksum      = $checksum
  checksumType  = 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" 
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs 

"chocolatey" | Out-File "$(Join-Path $installDir 'installer')" -NoNewline
