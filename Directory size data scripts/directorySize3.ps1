param (
    [string]$Target = ".",                        # Directory to process
    [string]$OutputPath = ".\output.csv"             # Output CSV file path
)

# Count the total number of top-level folders
$totalFolders = (Get-ChildItem -Path $Target -Directory).Count

# Initialize a counter
$currentFolder = 0

# Collect folder information
$folderData = Get-ChildItem -Path $Target -Directory | ForEach-Object {
    $currentFolder++

    # Calculate percentage completion
    $percentComplete = [int]($currentFolder / $totalFolders * 100)

    # Display progress bar
    Write-Progress -Activity "Processing Folders" `
                    -Status "Processing folder $currentFolder/$totalFolders ($_)" `
                    -PercentComplete $percentComplete

    $folderPath = $_.FullName

    # Get total size (recursive)
    $totalSize = (Get-ChildItem -Path $folderPath -Recurse -Force -File | Measure-Object -Property Length -Sum).Sum

    # Get top-level items and size (non-recursive)
    $topLevelItems = Get-ChildItem -Path $folderPath -Force
    $topLevelSize = ($topLevelItems | Where-Object { -not $_.PSIsContainer } | Measure-Object -Property Length -Sum).Sum
    $itemCount = $topLevelItems.Count

    # Return folder information
    [PSCustomObject]@{
        FolderName         = $folderPath
        TotalSizeInMB      = [math]::Round($totalSize / 1MB, 2)
        TopLevelSizeInMB   = [math]::Round($topLevelSize / 1MB, 2)
        TopLevelItemCount  = $itemCount
    }
}

# Sort the folder data by total size in descending order
$sortedData = $folderData | Sort-Object TotalSizeInMB -Descending

# Export sorted data to a CSV file
$sortedData | Export-Csv -Path $OutputPath -NoTypeInformation

# Completion message
Write-Host "Folder size data exported to $OutputPath" -ForegroundColor Green

