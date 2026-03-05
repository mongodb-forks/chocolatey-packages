$url         = 'https://github.com/mongodb/mongodb-atlas-cli/releases/download/atlascli/v1.53.1/mongodb-atlas-cli_1.53.1_windows_x86_64.msi'
$checksum    = '071fb6b24d030faf3ca9602c99f930f9bed73b81372f98db9e9cf234d3b45b98'

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
