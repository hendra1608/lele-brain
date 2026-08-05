[CmdletBinding()]
param([string]$BrainRoot)
$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($BrainRoot)) { $BrainRoot = Split-Path -Parent $PSScriptRoot }
$errors = [System.Collections.Generic.List[string]]::new()
$required = @('## Trigger','## Scope','## Required Context','## Inputs','## Workflow','## Outputs','## Validation','## Stop Conditions','## Safety Boundaries')
$skills = Get-ChildItem -LiteralPath (Join-Path $BrainRoot 'skills') -Directory
foreach ($skill in $skills) {
  $file = Join-Path $skill.FullName 'SKILL.md'
  if (-not (Test-Path -LiteralPath $file)) { $errors.Add("Missing SKILL.md: $($skill.Name)"); continue }
  $text = Get-Content -LiteralPath $file -Raw
  if ($text -notmatch '(?s)^---\s*\r?\nname:\s*.+\r?\ndescription:\s*.+\r?\n---') { $errors.Add("Invalid front matter: $($skill.Name)") }
  foreach ($heading in $required) { if ($text -notmatch [regex]::Escape($heading)) { $errors.Add("$($skill.Name) missing $heading") } }
}
$registry = Join-Path $BrainRoot 'skills\skill-registry.md'
if (-not (Test-Path -LiteralPath $registry)) { $errors.Add('Missing skill registry') } else {
  $registryText = Get-Content -LiteralPath $registry -Raw
  foreach ($skill in $skills | Where-Object { $_.Name -ne 'lele-orchestrator' }) { if ($registryText -notmatch [regex]::Escape($skill.Name)) { $errors.Add("Registry does not mention skill: $($skill.Name)") } }
}
$activationFile = Join-Path $BrainRoot 'tests\skill-activation-cases.md'
if (-not (Test-Path -LiteralPath $activationFile)) { $errors.Add('Missing activation test matrix') } else {
  $activationText = Get-Content -LiteralPath $activationFile -Raw
  foreach ($skill in $skills) { if ($activationText -notmatch [regex]::Escape($skill.Name)) { $errors.Add("Activation matrix does not cover skill: $($skill.Name)") } }
}
$orchestratorMetadata = Join-Path $BrainRoot 'skills\lele-orchestrator\agents\openai.yaml'
if (-not (Test-Path -LiteralPath $orchestratorMetadata)) { $errors.Add('Missing orchestrator metadata') }
$names = @()
foreach ($skill in $skills) { $names += [regex]::Match((Get-Content -LiteralPath (Join-Path $skill.FullName 'SKILL.md') -Raw), '(?m)^name:\s*(.+)$').Groups[1].Value.Trim() }
if (($names | Group-Object | Where-Object Count -gt 1).Count) { $errors.Add('Duplicate skill name metadata') }$knowledge = Get-Content -LiteralPath (Join-Path $BrainRoot 'rules\lele-knowledge.md') -Raw
if (([regex]::Matches($knowledge, '(?m)^# Lele Global Knowledge$')).Count -ne 1) { $errors.Add('Global knowledge must have exactly one authoritative H1') }
if ($knowledge -match '(?i)localStorage\("roles"\)|ROLE_MODULE|validateTokenRoleApi') { $errors.Add('Legacy SLP auth guidance leaked into global knowledge') }
foreach ($relative in @('sync-brain.ps1','workflows\lele.md')) {
  $text = Get-Content -LiteralPath (Join-Path $BrainRoot $relative) -Raw
  if ($text -match '(?im)^\s*git\s+.*\bpull\b|(?im)^\s*git\s+add\s+\.') { $errors.Add("Unsafe automatic sync command in $relative") }
}
if ($errors.Count) { $errors | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host "Lele Brain validation passed: $($skills.Count) skill folders checked." -ForegroundColor Green
