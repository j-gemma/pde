# Get the source directory from the script argument
$sourceDir = $args[0]

# Create the output directory if it doesn't exist
$outputDir = Join-Path $sourceDir "PDFs"
New-Item -ItemType Directory -Path $outputDir -Force

# Get all DOCX files in the source directory
$docxFiles = Get-ChildItem -Path $sourceDir -Filter *.docx

# Iterate through each DOCX file
foreach ($docxFile in $docxFiles) {
    $word = New-Object -ComObject Word.Application
    $doc = $word.Documents.Open($docxFile.FullName)

    # Construct the output PDF file path, escaping special characters
    $pdfFile = [System.IO.Path]::Combine($outputDir, $docxFile.BaseName + ".pdf")

    $doc.SaveAs([ref]$pdfFile, [ref]17) # 17 is the file format code for PDF
    $doc.Close()
    $word.Quit()
}

Write-Host "Conversion completed successfully."