# 設定變數
Set-Variable -Name "MyVariable" -Value "MyValue"-ErrorAction Stop -Scope Global

# 取得變數_所有
Get-Variable
# 取得變數_指定名稱
Get-Variable "MyVariable"
# 取得變數_指定名稱萬用字完篩選
Get-Variable "MyVar*"
# 取得變數_多重條件_指定名稱 M 開頭或 P 開頭的
Get-Variable -Include M*, P*


# 取得變數_指定範圍在本地
Get-Variable -Scope 0
# 取得變數_查找在父層 1 中定義但僅在本地 0 中可見的
Compare-Object (Get-Variable -Scope 0) (Get-Variable -Scope 1)

# 取得變數值
Get-Variable "MyVariable" -ValueOnly

# 顯示變數名稱
Get-Variable MyVariable | Select-Object -ExpandProperty Name