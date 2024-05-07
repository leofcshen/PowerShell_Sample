# 刪除資源回收桶超過 n 天的檔案

$days = $args[0]

# 定義刪除時間
$limit = (Get-Date).AddDays(-$days)
# 獲取資源回收桶位置
$recycle = (New-Object -ComObject Shell.Application).NameSpace(0xa)

$recycle.Items() | ForEach-Object {
  if($_.ExtendedProperty("System.Recycle.DateDeleted") -lt $limit){
    Remove-Item $_.Path -Recurse -Force
  }
}
