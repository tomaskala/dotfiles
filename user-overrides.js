user_pref("browser.safebrowsing.downloads.remote.enabled", true);  // 0402

user_pref("webgl.disabled", false);  // 2010
user_pref("webgl.dxgl.enabled", true); // [WINDOWS]
user_pref("webgl.enable-webgl2", true);

user_pref("dom.event.clipboardevents.enabled", true);  // 2402

user_pref("browser.cache.disk.enable", true);  // 1001

user_pref("keyword.enabled", true);  // 0801

user_pref("browser.sessionstore.privacy_level", 0);  // 1021

user_pref("browser.sessionstore.interval", 15000);  // 1023

user_pref("privacy.resistFingerprinting.letterboxing", false);  // 4504

user_pref("browser.startup.page", 3);  // 0102

user_pref("browser.privatebrowsing.autostart", false);  // 0110

user_pref("browser.display.use_document_fonts", 1);  // 1401

user_pref("privacy.clearOnShutdown.cache", true);  // 2803
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.formdata", false); // Form & Search History
user_pref("privacy.clearOnShutdown.history", false); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", false); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences

user_pref("privacy.cpd.cache", true);  // 2804
user_pref("privacy.cpd.cookies", false);
user_pref("privacy.cpd.formdata", false); // Form & Search History
user_pref("privacy.cpd.history", false); // Browsing & Download History
user_pref("privacy.cpd.offlineApps", true); // Offline Website Data
user_pref("privacy.cpd.passwords", true); // this is not listed
user_pref("privacy.cpd.sessions", false); // Active Logins
user_pref("privacy.cpd.siteSettings", false); // Site Preferences

user_pref("privacy.firstparty.isolate", false);  // 4001; disabled because of cookie autodelete
