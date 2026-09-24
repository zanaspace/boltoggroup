$htmlFiles = @(Get-ChildItem -Path "index.html"), @(Get-ChildItem -Path "pages/*.html")

$toggleHtml = @"
            <button class="mobile-toggle" aria-label="Toggle navigation">
                <span></span>
                <span></span>
                <span></span>
            </button>
            <nav class="main-nav">
"@

$scriptHtml = @"
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const toggle = document.querySelector('.mobile-toggle');
            const nav = document.querySelector('.main-nav');
            if(toggle && nav) {
                toggle.addEventListener('click', function(e) {
                    toggle.classList.toggle('is-active');
                    nav.classList.toggle('is-open');
                    e.stopPropagation();
                });
                document.addEventListener('click', function(e) {
                    if (nav.classList.contains('is-open') && !nav.contains(e.target) && !toggle.contains(e.target)) {
                        nav.classList.remove('is-open');
                        toggle.classList.remove('is-active');
                    }
                });
            }
        });
    </script>
</body>
"@

foreach ($file in $htmlFiles) {
    if ($null -ne $file -and (Test-Path $file.FullName)) {
        $content = Get-Content $file.FullName -Raw
        
        # Inject toggle button if not exists
        if ($content -notmatch 'class="mobile-toggle"') {
            $content = $content -replace '(?i)[ \t]*<nav class="main-nav">', $toggleHtml
        }
        
        # Inject script if not exists
        if ($content -notmatch "mobile-toggle'.*?click") {
            $content = $content -replace '</body>', $scriptHtml
        }
        
        Set-Content -Path $file.FullName -Value $content
    }
}
Write-Output "Sidebar injected."
