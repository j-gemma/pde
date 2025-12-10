param (
    [string]$TargetPath = ".",
    [string]$OutputPath = "C:.\directoryData.csv" # Adjust this path as needed
)

# Read the content of the file at the specified TargetPath
$lines = Get-Content $TargetPath

$formattedData = $lines | ForEach-Object {
    if ($_ -match '^(\d+)\s+-\s+(.*)\s+(\d+(\.\d+)?)$') {
        [PSCustomObject]@{
            ProjectNumber = $matches[1]
            ProjectName   = $matches[2].Trim()
            SizeInMB      = [decimal]$matches[3]
        }
    }
}

# Export the formatted data to a CSV file
$formattedData | Export-Csv -Path $OutputPath -NoTypeInformation

Write-Host "Data exported to $OutputPath"
