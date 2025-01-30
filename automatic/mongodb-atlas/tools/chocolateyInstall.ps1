$url         = 'https://github.com/mongodb/mongodb-atlas-cli/releases/download/atlascli/v1.37.0/mongodb-atlas-cli_1.37.0_windows_x86_64.msi'
$checksum    = 'e2c1627647f552f049ecd1b45422ed3be66c7e585523bbd08216b782ebee3603'

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
