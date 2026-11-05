# Build the unsigned Windows Inno Setup installer after flutter build windows --release.
$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$Pubspec = Get-Content (Join-Path $Root "pubspec.yaml") | Where-Object { $_ -match '^version:' } | Select-Object -First 1
if (-not $Pubspec) { throw "Could not parse version from pubspec.yaml" }
$Version = ($Pubspec -replace '^version:\s*', '' -replace '\+.*$', '').Trim()

$ReleaseDir = Join-Path $Root "build\windows\x64\runner\Release"
$Exe = Join-Path $ReleaseDir "flanexec.exe"
if (-not (Test-Path $Exe)) {
  throw "Missing $Exe — run: flutter build windows --release"
}

$Dist = Join-Path $Root "dist"
New-Item -ItemType Directory -Force -Path $Dist | Out-Null

$Iscc = $env:INNO_SETUP_ISCC
if (-not $Iscc) {
  $candidates = @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "${env:ProgramFiles}\Inno Setup 6\ISCC.exe",
    "${env:LOCALAPPDATA}\Programs\Inno Setup 6\ISCC.exe"
  )
  foreach ($c in $candidates) {
    if (Test-Path $c) { $Iscc = $c; break }
  }
}
if (-not $Iscc -or -not (Test-Path $Iscc)) {
  throw "ISCC.exe not found. Install Inno Setup 6 or set INNO_SETUP_ISCC."
}

$Iss = Join-Path $PSScriptRoot "flanexec.iss"
& $Iscc `
  "/DFLANEXEC_VERSION=$Version" `
  "/DFLANEXEC_ROOT=$Root" `
  $Iss

$Out = Join-Path $Dist "flanexec-$Version-windows-x64-setup.exe"
if (-not (Test-Path $Out)) { throw "Expected installer not found: $Out" }
Write-Host "created $Out"
