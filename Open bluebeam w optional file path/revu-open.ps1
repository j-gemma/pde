param (
    [Parameter(Mandatory = $true)]
    [string]$PdfPath
)

# Path to the Bluebeam Revu executable
$bluebeamPath = "C:\Program Files (x86)\Bluebeam Software\Bluebeam Revu\21\Revu\Revu32.exe"

# Check if both the executable and the PDF exist
if ((Test-Path $bluebeamPath) -and (Test-Path $PdfPath)) {
    Start-Process -FilePath $bluebeamPath -ArgumentList "`"$PdfPath`""
} else {
    if (-not (Test-Path $bluebeamPath)) {
        Write-Host "Bluebeam Revu was not found at the expected path: $bluebeamPath"
    }
    if (-not (Test-Path $PdfPath)) {
        Write-Host "PDF file was not found at the provided path: $PdfPath"
    }
}

