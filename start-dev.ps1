$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$backend = Join-Path $root 'gravity_flip_backend'
$frontend = Join-Path $root 'gravity_flip_game'
$python = Join-Path $root '.venv-1\Scripts\python.exe'

if (-not (Test-Path $python)) {
    $python = 'python'
}

Write-Host ''
Write-Host 'Gravity Flip full-stack development server' -ForegroundColor Cyan
Write-Host 'Backend:  http://127.0.0.1:8000/'
Write-Host 'Health:   http://127.0.0.1:8000/health/'
Write-Host 'Swagger:  http://127.0.0.1:8000/api/docs/'
Write-Host 'Frontend: http://127.0.0.1:8080/'
Write-Host ''

$backendJob = Start-Job -Name GravityFlipBackend -ScriptBlock {
    param($project, $interpreter)
    Set-Location $project
    & $interpreter manage.py runserver 127.0.0.1:8000
} -ArgumentList $backend, $python

$frontendJob = Start-Job -Name GravityFlipFrontend -ScriptBlock {
    param($project, $interpreter)
    Set-Location $project
    flutter build web --release --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1
    & $interpreter -m http.server 8080 --directory (Join-Path $project 'build\web')
} -ArgumentList $frontend, $python

try {
    while ($true) {
        Receive-Job -Name GravityFlipBackend, GravityFlipFrontend
        Start-Sleep -Milliseconds 250
    }
}
finally {
    Stop-Job -Name GravityFlipBackend, GravityFlipFrontend -ErrorAction SilentlyContinue
    Remove-Job -Name GravityFlipBackend, GravityFlipFrontend -Force -ErrorAction SilentlyContinue
}