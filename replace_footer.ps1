$newFooter = @"
    <!-- Global Footer -->
    <footer class="global-footer">
        <div class="footer-container">
            <div class="footer-grid">
                <!-- Column 1: Brand & About -->
                <div class="footer-col">
                    <img src="assets/images/logo.png" alt="Boltog Group Logo" class="footer-logo">
                    <p class="footer-about">Boltog Group Ltd provides world-class Engineering, Procurement, and Construction services globally. Delivering operational excellence for the Energy and Oil & Gas sectors.</p>
                    <div class="social-links">
                        <a href="https://www.facebook.com/BoltogGroup" target="_blank" title="Facebook" class="social-icon">
                            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M22 12c0-5.52-4.48-10-10-10S2 6.48 2 12c0 4.84 3.44 8.87 8 9.8V15H8v-3h2V9.5C10 7.57 11.57 6 13.5 6H16v3h-2c-.55 0-1 .45-1 1v2h3v3h-3v6.95c5.05-.5 9-4.76 9-9.95z"/></svg>
                        </a>
                        <a href="https://x.com/BoltogGroup" target="_blank" title="X (Twitter)" class="social-icon">
                            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
                        </a>
                        <a href="http://www.ng.linkedin.com/pub/boltog-group-nigeria/58/560/6b" target="_blank" title="LinkedIn" class="social-icon">
                            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M19 3a2 2 0 012 2v14a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h14m-.5 15.5v-5.3a3.26 3.26 0 00-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 011.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 001.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 00-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"/></svg>
                        </a>
                    </div>
                </div>
                
                <!-- Column 2: Quick Links -->
                <div class="footer-col">
                    <h5>Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="about.html">About Us</a></li>
                        <li><a href="services.html">Our Services</a></li>
                        <li><a href="products.html">Our Products</a></li>
                        <li><a href="index.html#clients">Clients & Partners</a></li>
                        <li><a href="contact.html">Contact Us</a></li>
                    </ul>
                </div>
                
                <!-- Column 3: Our Expertise -->
                <div class="footer-col">
                    <h5>Our Expertise</h5>
                    <ul class="footer-links">
                        <li><a href="products_octg.html">OCTG Supply</a></li>
                        <li><a href="services.html">Facility Management</a></li>
                        <li><a href="services.html">Engineering & Design</a></li>
                        <li><a href="services.html">Oil & Gas Inspection</a></li>
                        <li><a href="about.html">HQS & Environment</a></li>
                    </ul>
                </div>
                
                <!-- Column 4: Contact -->
                <div class="footer-col">
                    <h5>Global Office</h5>
                    <address class="footer-address">
                        <strong>Boltog Innovation Centre</strong><br>
                        12/14 Babs Animashaun Street,<br>
                        Surulere, Lagos State, Nigeria<br><br>
                        <strong>Mobile:</strong> +234 805 5095 960<br>
                        <strong>Web:</strong> www.boltoggroup.com
                    </address>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2017 - 2026 Boltog Group Ltd. All Rights Reserved.</p>
                <div>
                    <a href="https://www.boltoggroup.com:2096/" target="_blank" class="staff-login-btn">Staff Login Portal</a>
                </div>
            </div>
        </div>
    </footer>
"@

$files = Get-ChildItem -Filter *.html
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    $content = $content -replace '(?s)    <!-- Global Footer -->.*?    </footer>', $newFooter
    
    # Avoid adding link if already added (safety)
    if ($content -notmatch 'footer.css') {
        $content = $content -replace '<link rel="stylesheet" href="styles.css">', "<link rel=`"stylesheet`" href=`"styles.css`">`n    <link rel=`"stylesheet`" href=`"footer.css`">"
    }
    
    Set-Content -Path $f.FullName -Value $content
}
