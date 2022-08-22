$CarColor = 'Blue'

function get-kk {
	param (
		[switch] $BoolFlag
	)

	@{ $true = 'The true'; $false = 'The false' }[$BoolFlag.IsPresent]
}
$b = get-kk
Write-Output $b
$b = get-kk -BoolFlag
Write-Output $b

# @{ $true = 'The car color is blue'; $false = 'The car color is not blue' }[$CarColor -eq 'Blue']
Write-Output @{ $true = 'The car color is blue'; $false = 'The car color is not blue' }[$true]
Write-Output @{ $true = 'The car color is blue'; $false = 'The car color is not blue' }[$false]

$number = 0
("0", "1", "2")[$number]
$number = 1
("0", "1", "2")[$number]
$number = 2
("0", "1", "2")[$number]