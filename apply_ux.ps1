$indexFile = "index.html"
$pagesFiles = Get-ChildItem -Path "pages/*.html"

# 1. Update Index Hero Buttons
$idxContent = Get-Content $indexFile -Raw
$heroBtnOrig = '<a href="pages/contact.html" class="btn btn-primary">Get a Free Quote</a>'
$heroBtnNew = '<a href="pages/contact.html" class="btn btn-primary">Get a Free Quote</a>' + "`n                    " + '<a href="pages/services.html" class="btn btn-outline" style="margin-left: 10px;">Explore Our Services</a>'
$idxContent = $idxContent -replace [regex]::Escape($heroBtnOrig), $heroBtnNew

# 2. Update Dropdown in index.html
$dropdownIndex = @"
<li class="nav-dropdown">
    <a href="pages/products.html">Products &#9660;</a>
    <ul class="dropdown-menu">
        <li><a href="pages/products_drilling.html">Drilling Equipment</a></li>
        <li><a href="pages/products_cementing.html">Cementing & Casing</a></li>
        <li><a href="pages/products_octg.html">OCTG Solutions</a></li>
    </ul>
</li>
"@
$idxContent = $idxContent -replace '<li><a href="pages/products.html">Products</a></li>', $dropdownIndex

# Inject Back-to-top and Observer JS in index.html
$bttHtml = '<button id="backToTop" class="back-to-top" aria-label="Back to Top">&#8593;</button>'
$uxJs = @"
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Back to top
            const backToTop = document.getElementById('backToTop');
            if (backToTop) {
                window.addEventListener('scroll', () => {
                    if (window.scrollY > 300) backToTop.classList.add('visible');
                    else backToTop.classList.remove('visible');
                });
                backToTop.addEventListener('click', () => {
                    window.scrollTo({top: 0, behavior: 'smooth'});
                });
            }
            // AOS Scroll
            const observer = new IntersectionObserver(entries => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                    }
                });
            });
            document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));
        });
    </script>
"@
if ($idxContent -notmatch 'id="backToTop"') {
    $idxContent = $idxContent -replace '</body>', "$bttHtml`n$uxJs`n</body>"
}
# Add fade-in classes
$idxContent = $idxContent -replace 'class="card"', 'class="card fade-in"'
$idxContent = $idxContent -replace 'class="stat-box"', 'class="stat-box fade-in"'
Set-Content -Path $indexFile -Value $idxContent

# Do the same for Pages
$dropdownPages = @"
<li class="nav-dropdown">
    <a href="products.html">Products &#9660;</a>
    <ul class="dropdown-menu">
        <li><a href="products_drilling.html">Drilling Equipment</a></li>
        <li><a href="products_cementing.html">Cementing & Casing</a></li>
        <li><a href="products_octg.html">OCTG Solutions</a></li>
    </ul>
</li>
"@

foreach ($file in $pagesFiles) {
    if ($null -ne $file -and (Test-Path $file.FullName)) {
        $content = Get-Content $file.FullName -Raw
        
        $content = $content -replace '<li><a href="products.html">Products</a></li>', $dropdownPages
        $activeProducts = '<li><a href="products.html" class="active">Products</a></li>'
        $activeDropdown = $dropdownPages -replace 'href="products.html"', 'href="products.html" class="active"'
        $content = $content -replace [regex]::Escape($activeProducts), $activeDropdown
        
        if ($content -notmatch 'id="backToTop"') {
            $content = $content -replace '</body>', "$bttHtml`n$uxJs`n</body>"
        }
        $content = $content -replace 'class="card"', 'class="card fade-in"'
        $content = $content -replace 'class="stat-box"', 'class="stat-box fade-in"'
        
        Set-Content -Path $file.FullName -Value $content
    }
}

# Fix the services accordion (ensure only first is open)
$srvContent = Get-Content "pages/services.html" -Raw
$srvContent = $srvContent -replace '<details class="accordion-item" open>', '<details class="accordion-item">'
$regex = [regex] '<details class="accordion-item">'
$srvContent = $regex.Replace($srvContent, '<details class="accordion-item" open>', 1)
Set-Content -Path "pages/services.html" -Value $srvContent

Write-Output "UX features injected."
