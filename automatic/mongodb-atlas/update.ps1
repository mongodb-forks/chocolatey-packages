import-module au

$releases = 'https://api.github.com/repos/mongodb/mongodb-atlas-cli/releases'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-RestMethod -Uri $releases

    $url = $download_page | % assets | ? browser_download_url -match 'mongodb-atlas-cli_.*\.msi$' | % browser_download_url | select -First 1

    $version = $url -split '/' | select -Last 1 -Skip 1
    $version = $version.substring(1)

    $Latest = @{ URL64 = $url; Version = $version }
    return $Latest
}

update -ChecksumFor 64
