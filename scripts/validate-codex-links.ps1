[CmdletBinding()]
param(
  [string]$BrainRoot = 'C:\Users\hendra.hendra\Desktop\SLP\lele-brain',
  [string]$CodexSkillRoot = 'C:\Users\hendra.hendra\.codex\skills'
)
$ErrorActionPreference = 'Stop'
$mapping = @{'lele'='lele-orchestrator';'lele-ai-native-mastery'='ai-native-mastery';'lele-cloud-edge-orchestra'='cloud-edge-orchestra';'lele-contract-first-api-integration'='contract-first-api-integration';'lele-database-schema-migration'='database-schema-migration';'lele-fullstack-auth-debugger'='fullstack-auth-debugger';'lele-librarian-compiler'='librarian-compiler';'lele-performance-optimizer'='performance-optimizer';'lele-refactoring-debt-eraser'='refactoring-debt-eraser';'lele-security-protocol'='security-protocol';'lele-state-mastery'='state-mastery';'lele-strategic-planner'='strategic-planner';'lele-ui-premium-vault'='ui-premium-vault';'lele-verification-release-gate'='verification-release-gate'}
$errors = [System.Collections.Generic.List[string]]::new()
foreach ($name in $mapping.Keys) {
  $path = Join-Path $CodexSkillRoot $name
  $expected = [IO.Path]::GetFullPath((Join-Path $BrainRoot ('skills\' + $mapping[$name])))
  if (-not (Test-Path -LiteralPath $path)) { $errors.Add("Missing Codex link: $name"); continue }
  $item = Get-Item -LiteralPath $path -Force
  if ($item.LinkType -notin @('SymbolicLink','Junction')) { $errors.Add("Not a source link: $name"); continue }
  $actual = [IO.Path]::GetFullPath([string]$item.Target)
  if ($actual -ne $expected) { $errors.Add("Wrong target for ${name}: $actual") }
  $linkedSkill = Join-Path $path 'SKILL.md'; $sourceSkill = Join-Path $expected 'SKILL.md'
  if (-not (Test-Path -LiteralPath $linkedSkill)) { $errors.Add("Unusable skill link: $name") }
  elseif ((Get-FileHash -Algorithm SHA256 -LiteralPath $linkedSkill).Hash -ne (Get-FileHash -Algorithm SHA256 -LiteralPath $sourceSkill).Hash) { $errors.Add("Source drift in link: $name") }
}
$managed = Get-ChildItem -LiteralPath $CodexSkillRoot -Directory -Force | Where-Object { $_.Name -like 'lele*' }
foreach ($item in $managed) {
  if (-not $mapping.ContainsKey($item.Name)) { $errors.Add("Unexpected Lele skill directory in discovery path: $($item.Name)"); continue }
  if ($item.LinkType -notin @('SymbolicLink','Junction')) { $errors.Add("Lele skill is not linked to source: $($item.Name)") }
}
$identities = foreach ($item in $managed) {
  $skill = Join-Path $item.FullName 'SKILL.md'
  if (Test-Path -LiteralPath $skill) { [pscustomobject]@{ Directory=$item.Name; Name=[regex]::Match((Get-Content -LiteralPath $skill -Raw),'(?m)^name:\s*(.+)$').Groups[1].Value.Trim() } }
}
foreach ($duplicate in $identities | Group-Object Name | Where-Object Count -gt 1) { $errors.Add("Duplicate installed Lele skill identity: $($duplicate.Name)") }
if ($errors.Count) { $errors | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host "Codex link validation passed: $($mapping.Count) Lele source links with unique identities." -ForegroundColor Green