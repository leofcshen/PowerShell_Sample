try {
  1/0
}
catch {
  Write-Host $_.Exception.Message -ForegroundColor Red
  Write-Host $_.ScriptStackTrace

  New-Item -ItemType Directory -Force -Path $PSScriptRoot\Log
  ConvertTo-Json $Error | Out-File -FilePath $PSScriptRoot\Log\Log.json
}