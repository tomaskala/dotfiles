// Restore last session on startup.
user_pref("browser.startup.page", 3);  // 0102

// Use the 'about:home' page when opening a new tab.
user_pref("browser.startup.homepage", "about:home");  // 0103
user_pref("browser.newtabpage.enabled", true);  // 0104
user_pref("browser.newtab.preload", true);

// Do not start the browser in private mode.
user_pref("browser.privatebrowsing.autostart", false);  // 0110

// Enable real time binary checks with Google services.
user_pref("browser.safebrowsing.downloads.remote.enabled", true);  // 0402

// Make the URL bar work as a search bar again -- allow if you use a privacy
// respecting search engine.
user_pref("keyword.enabled", true);  // 0801

// Enable disk cache.
user_pref("browser.cache.disk.enable", true);  // 1001

// Enable storing extra session data such as the scrollbar positions.
user_pref("browser.sessionstore.privacy_level", 0);  // 1021

// Reset the minimum time interval between session save operations.
user_pref("browser.sessionstore.interval", 15000);  // 1023

// Allow webpages to push their own fonts.
user_pref("browser.display.use_document_fonts", 1);  // 1401

// Enable WebGL.
user_pref("webgl.disabled", false);  // 2010
user_pref("webgl.dxgl.enabled", true); // [WINDOWS]
user_pref("webgl.enable-webgl2", true);

// Enable webpages to register clipboard events. Otherwise, Jupyter and
// Zeppelin notebooks do not work correctly.
user_pref("dom.event.clipboardevents.enabled", true);  // 2402

// Do not clear everything on shutdown.
user_pref("privacy.clearOnShutdown.cookies", false);  // 2803
user_pref("privacy.clearOnShutdown.sessions", false);
user_pref("privacy.clearOnShutdown.siteSettings", false);

// Autoselect the same settings as 2803 when pressing Ctrl+Shift+Del.
user_pref("privacy.cpd.cookies", false);  // 2804
user_pref("privacy.cpd.sessions", false);
user_pref("privacy.cpd.siteSettings", false);

// Disabled because of cookie autodelete.
user_pref("privacy.firstparty.isolate", false);  // 4001

// Do not show the annoying white frame around webpages.
user_pref("privacy.resistFingerprinting.letterboxing", false);  // 4504
