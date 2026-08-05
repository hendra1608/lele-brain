[CmdletBinding(SupportsShouldProcess = $true)]
param(
  [string[]]$Stage,
  [string]$Message,
  [switch]$Commit,
  [switch]$ConfirmCommit
)
$ErrorActionPreference = 'Stop'
$brain = Split-Path -Parent $PSCommandPath
Set-Location $brain
function Test-SecretText([string]$Text, [string]$Path) {
  $patterns = @(
    '(?i)-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----',
    '(?i)\b(?:api[_-]?key|secret|token|password)\s*[:=]\s*\S{16,}',
    '(?i)AKIA[0-9A-Z]{16}',
    '(?i)\b(?:ghp|github_pat|sk-|AIza)[A-Za-z0-9_-]{16,}',
    '(?i)(?:postgres|mysql|mongodb).{0,12}://\S+'
  )
  foreach ($pattern in $patterns) { if ($Text -match $pattern) { throw "Potential secret detected in $Path. Remove it or use approved secret handling before staging." } }
}
Write-Host 'Lele Brain local-first status (read-only by default)' -ForegroundColor Cyan
git status --short --branch
if (-not $Stage -and -not $Commit) { Write-Host 'No write action requested. Review the diff manually; this script never pulls or pushes.' -ForegroundColor Yellow; exit 0 }
if (-not $Stage) { throw 'Provide explicit -Stage paths. Broad staging is intentionally unsupported.' }
foreach ($relative in $Stage) {
  $path = Join-Path $brain $relative
  if (-not (Test-Path -LiteralPath $path)) { throw "Stage path does not exist: $relative" }
  if ((Get-Item -LiteralPath $path).PSIsContainer) { throw "Stage accepts files only, not directories: $relative" }
  Test-SecretText ([System.IO.File]::ReadAllText($path)) $relative
}
if ($PSCmdlet.ShouldProcess(($Stage -join ', '), 'stage explicit files')) { git add -- $Stage }
git diff --cached --check
Write-Host 'Staged diff is ready for review:' -ForegroundColor Cyan
git diff --cached --stat
if (-not $Commit) { exit 0 }
if (-not $ConfirmCommit) { throw 'Commit requires -ConfirmCommit after reviewing the staged diff.' }
if ([string]::IsNullOrWhiteSpace($Message)) { throw 'Commit requires a non-empty -Message.' }
Test-SecretText (git diff --cached) 'staged diff'
if ($PSCmdlet.ShouldProcess($Message, 'create local commit')) { git commit -m $Message }
Write-Host 'Local commit created. Push remains a separate explicit Git action.' -ForegroundColor Green