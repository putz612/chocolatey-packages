$ErrorActionPreference = 'Stop'

$url        = ''
$checksum   = ''

$unzipLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\bitnami")) {
  if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\bitnami\tools")) {
    # clean old plugins and ignore files
    Write-Host "Removing old terraform plugins"
    Remove-Item "$env:ChocolateyInstall\lib\bitnami\tools\kubeseal-*.*"
  }
} else {
  if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\bitnami")) {
    if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\bitnami\tools")) {
      # clean old plugins and ignore files
      Write-Host "Removing old kubeseal plugins"
      Remove-Item "$env:ALLUSERSPROFILE\chocolatey\lib\bitnami\tools" -Include "kubeseal-*.*"
    }
  }
}

$packageParams = @{
  PackageName   = "kubeseal"
  UnzipLocation = $unzipLocation
  Url           = $url
  Checksum      = $checksum
  ChecksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageParams
