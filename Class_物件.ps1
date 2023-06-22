class Vehicle {
	[string] $Name;

	Vehicle() {
		Write-Host "父層空建構函式" -ForegroundColor Green;
	}

	Vehicle([string] $Name) {
		$this.Name = $Name;
	}
}

# 繼承
class Car : Vehicle {
	[int] $Mileage;
	[string] $Color;

	Car() {
		Write-Host "子層空建構函式" -ForegroundColor Red;
	}
	# 沒指定 Base($Name) 會呼父層空建構函式
	Car([string] $Name) : Base($Name) {	}

	Car([string] $Name, [int] $Mileage) : Base($Name) {
		$this.Mileage = $Mileage;
	}

	[void] Drive([int] $Mileage) {
		$this.Mileage += $Mileage
	}
}

[Car]::new();
[Car]::new('BMW');
[Car]::new('Audi', 20000);

$MyCar = [Car]::new('MyCar')
$MyCar.Color = "Red"
$MyCar.Drive(12)
$MyCar