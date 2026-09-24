import os
import re

footer_html = """    <!-- Global Footer -->
    <footer class="global-footer">
        <div class="container">
            <div class="footer-grid">
                <!-- Column 1: Logo & Connect -->
                <div class="footer-col">
                    <img src="assets/images/logo.png" alt="Boltog Group Logo" class="footer-logo">
                    <h5 class="mt-4">CONNECT WITH US</h5>
                    <p class="mt-4"><a href="#" class="footer-link"><strong>Staff Login</strong></a></p>
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
                    <ul class="footer-links">
                        <li><a href="index.html">&rsaquo; Home</a></li>
                        <li><a href="about.html">&rsaquo; About Us</a></li>
                        <li><a href="services.html">&rsaquo; Services</a></li>
                        <li><a href="products.html">&rsaquo; Products</a></li>
                        <li><a href="index.html#clients">&rsaquo; Clients</a></li>
                        <li><a href="index.html#clients">&rsaquo; Partners</a></li>
                        <li><a href="contact.html">&rsaquo; Contact</a></li>
                    </ul>
                </div>
                
                <!-- Column 3: Key Areas -->
                <div class="footer-col">
                    <ul class="footer-links">
                        <li><a href="products_octg.html">&rsaquo; OCTG Supply</a></li>
                        <li><a href="services.html">&rsaquo; Facility Management (Onshore, Offshore & Deep Offshore)</a></li>
                        <li><a href="services.html">&rsaquo; Engineering, Design & Drafting</a></li>
                        <li><a href="services.html">&rsaquo; Oil & Gas Facility Inspection</a></li>
                        <li><a href="about.html">&rsaquo; Quality Health & Safety and the Environment (HQS&E)</a></li>
                    </ul>
                </div>
                
                <!-- Column 4: Contact Info -->
                <div class="footer-col">
                    <h5>CONTACT INFO</h5>
                    <address class="footer-address">
                        Boltog Energy Ltd,<br>
                        Boltog Innovation Centre,<br>
                        12/14 Babs Animashaun Street,<br>
                        Surulere Lagos State, Nigeria<br>
                        Mobile: +234 805 5095 960<br>
                        Web: www.boltoggroup.com
                    </address>
                </div>
            </div>
        </div>
    </footer>"""

html_files = [f for f in os.listdir('.') if f.endswith('.html')]
for file in html_files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = re.sub(r'<!-- Global Footer -->.*?</footer>', footer_html, content, flags=re.DOTALL)
    
    with open(file, 'w', encoding='utf-8') as f:
        f.write(new_content)
print("Updated all footers!")
