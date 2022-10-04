class Car {
	[string] $Color;
	[string] $Name;

	[int] $Length
	[int] $Width

	[string] $Manufacturer;
	[string] $Model;

	[int] $Mileage;

	[void] Drive([int] $Mileage) {
		$this.Mileage += $Mileage
	}
}

$MyCar = [Car]::new()
$MyCar.Manufacturer = "Bwm"
$MyCar.Drive(12)