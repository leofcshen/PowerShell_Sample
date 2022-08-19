$lists = @(
	[PSCustomObject]@{ Name = "Tom"; Age = "22" },
	[PSCustomObject]@{ Name = "Joe"; Age = "23" },
	[PSCustomObject]@{ Name = "May"; Age = "24" }
);

# 方法一
$lists.ForEach({ Write-Output "$($_.Name) $($_.Age)" })
# 方法二
$lists | ForEach-Object { Write-Output "$($_.Name) $($_.Age)" }
# 方法三
foreach ($item in $lists) { Write-Output "$($item.Name) $($item.Age)" }
