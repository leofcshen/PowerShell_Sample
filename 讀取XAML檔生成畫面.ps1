
Add-Type -AssemblyName PresentationFramework
# 指定用來生成畫面的 xaml 檔
$xamlFile = (Get-Item -Path ..\MainWindow.xaml).FullName
$inputXAML = Get-Content -Path $xamlFile -Raw
# 轉換 xaml 內容
$inputXAML = $inputXAML -replace 'mc:Ignorable="d"', '' -replace "x:N", "N" -replace	'^<Win.*', '<Window'
[XML]$XAML = $inputXAML
# 讀取 xaml 內容
$reader = New-Object System.Xml.XmlNodeReader $XAML

try {
	# 載入 xaml 內容
	$psForm = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
	throw
}

# 把畫面元件名稱加上 var_開頭方便使用
$xaml.SelectNodes("//*[@Name]") <#選有 Name 的 node #> | ForEach-Object {
	try {
		Set-Variable -Name "form_$($_.Name)" -Value $psForm.FindName($_.Name) -ErrorAction Stop
	}
	catch {
		throw
	}
}

# 找所有變數
# Get-Variable
# 找畫面元件變數
Get-Variable form_*

# 將視窗設定為最上層顯示
$psForm.Topmost = $false

$psForm.ShowDialog()
