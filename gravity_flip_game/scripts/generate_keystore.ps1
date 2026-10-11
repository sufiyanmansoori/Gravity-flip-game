<#
PowerShell helper script: generate_keystore.ps1
Purpose: interactively generate a release keystore using keytool and create android/key.properties
Usage (run in PowerShell from project root):
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  .\scripts\generate_keystore.ps1

Security note: key.properties contains plaintext passwords. Do NOT commit it to a public repository.
#>

param(
  [string]$KeystorePath = "$env:USERPROFILE\.android\release-keystore.jks",
  [string]$Alias = 'gravityflip_key'
)

Write-Host "Keystore path: $KeystorePath"
Write-Host "Key alias: $Alias"

# ask user for passwords
$storePassword = Read-Host -Prompt 'Enter a password for the keystore (storePassword)'
$keyPassword = Read-Host -Prompt 'Enter a password for the key (keyPassword) - press Enter to use same as storePassword'
if ([string]::IsNullOrEmpty($keyPassword)) { $keyPassword = $storePassword }

# distinguished name details
$cn = Read-Host -Prompt 'Enter your name or company (CN) [Gravity Flip]' -Default 'Gravity Flip'
$ou = Read-Host -Prompt 'Organizational unit (OU) [Game Dev]' -Default 'Game Dev'
$o = Read-Host -Prompt 'Organization (O) [Your Company]' -Default 'Your Company'
$l = Read-Host -Prompt 'Locality / City (L) [City]' -Default 'City'
$s = Read-Host -Prompt 'State / Province (S) [State]' -Default 'State'
$c = Read-Host -Prompt 'Country code (C) [IN]' -Default 'IN'

$dname = "CN=$cn, OU=$ou, O=$o, L=$l, S=$s, C=$c"

# ensure directory exists
$dir = Split-Path $KeystorePath -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

# Generate the keystore using keytool
$keytool = 'keytool'
Write-Host "Running keytool to generate keystore..."
$cmd = "$keytool -genkeypair -v -keystore \"$KeystorePath\" -storepass $storePassword -keypass $keyPassword -alias $Alias -keyalg RSA -keysize 2048 -validity 10000 -dname \"$dname\""
Write-Host $cmd
& $keytool -genkeypair -v -keystore "$KeystorePath" -storepass $storePassword -keypass $keyPassword -alias $Alias -keyalg RSA -keysize 2048 -validity 10000 -dname "$dname"

if ($LASTEXITCODE -ne 0) { Write-Error "keytool failed. Ensure Java JDK is installed and keytool is on PATH."; exit 1 }

# Write android/key.properties
$keyPropsPath = Join-Path -Path (Join-Path -Path (Resolve-Path '.') -ChildPath 'android') -ChildPath 'key.properties'
$keyPropsContent = @"
storePassword=$storePassword
keyPassword=$keyPassword
keyAlias=$Alias
storeFile=$KeystorePath
"@

Write-Host "Writing key.properties to: $keyPropsPath"
Set-Content -Path $keyPropsPath -Value $keyPropsContent -Encoding UTF8

Write-Host "Keystore generated and key.properties created. IMPORTANT: Do not commit the keystore or key.properties to public repositories." -ForegroundColor Green
Write-Host "Keystore path: $KeystorePath"
Write-Host "key.properties path: $keyPropsPath"
