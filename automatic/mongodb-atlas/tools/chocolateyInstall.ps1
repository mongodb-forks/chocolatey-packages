$url         = 'https://github.com/mongodb/mongodb-atlas-cli/releases/download/atlascli/v1.36.0/mongodb-atlas-cli_1.36.0_windows_x86_64.msi'
$checksum    = '1703da58069ee8e44c15110aee8b4dd9f97fa5d9ac6367f56727d164a175190d'

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
