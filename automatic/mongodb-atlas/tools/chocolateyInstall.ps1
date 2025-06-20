$url         = 'https://github.com/mongodb/mongodb-atlas-cli/releases/download/atlascli/v1.44.0/mongodb-atlas-cli_1.44.0_windows_x86_64.msi'
$checksum    = '57343b5f7fc6e5388b64b4e367ca0dedd6efdd31e78f6b0a56270214bf17ca1e'

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
