# Sync Lele Brain to GitHub
cd "C:\Users\hendra.hendra\.gemini\antigravity\lele-brain"
git add .
git commit -m "update lele brain memory: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin main
Write-Host "Lele's Brain has been uploaded to the Cloud! 🐟" -ForegroundColor Cyan
