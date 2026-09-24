$htmlFiles = @("about.html", "services.html", "products.html", "products_octg.html", "products_drilling.html", "products_cementing.html", "contact.html")

New-Item -ItemType Directory -Force -Path "pages"
New-Item -ItemType Directory -Force -Path "css"

# Update index.html
$idxContent = Get-Content "index.html" -Raw
$idxContent = $idxContent -replace 'href="styles.css"', 'href="css/styles.css"'
$idxContent = $idxContent -replace 'href="footer.css"', 'href="css/footer.css"'
foreach ($file in $htmlFiles) {
    $idxContent = $idxContent -replace "href=`"$file`"", "href=`"pages/$file`""
}
Set-Content "index.html" -Value $idxContent

# Update and move nested HTML files
foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # CSS paths
        $content = $content -replace 'href="styles.css"', 'href="../css/styles.css"'
        $content = $content -replace 'href="footer.css"', 'href="../css/footer.css"'
        
        # Asset paths (covers both src="..." and url('...'))
        $content = $content -replace 'src="assets/', 'src="../assets/'
        $content = $content -replace "url\('assets/", "url('../assets/"
        $content = $content -replace 'url\("assets/', 'url("../assets/'
        
        # Links back to index
        $content = $content -replace 'href="index.html"', 'href="../index.html"'
        # (index.html#clients is covered by the above replace)
        
        # Save and move
        Set-Content $file -Value $content
        Move-Item -Path $file -Destination "pages/$file" -Force
    }
}

# Move CSS files
if (Test-Path "styles.css") { Move-Item -Path "styles.css" -Destination "css/styles.css" -Force }
if (Test-Path "footer.css") { Move-Item -Path "footer.css" -Destination "css/footer.css" -Force }

Write-Output "Organization complete."
