// Betterfox-Auswahl für mi2iur0l.dev-edition-default (Firefox Dev Edition 159)
// Nur Prefs, die noch nicht gesetzt sind und keine Seiten brechen.

/** SPEED ***/
user_pref("content.notify.interval", 100000);
user_pref("gfx.canvas.accelerated.cache-size", 512);
user_pref("gfx.content.skia-font-cache-size", 20);
user_pref("image.mem.decode_bytes_at_a_time", 32768);
user_pref("media.cache_readahead_limit", 3600);
user_pref("media.cache_resume_threshold", 1800);
user_pref("network.http.max-connections", 1800);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
user_pref("network.http.request.max-start-delay", 5);
user_pref("network.dnsCacheExpiration", 3600);
user_pref("security.OCSP.enabled", 0); // CRLite übernimmt, spart einen Roundtrip pro TLS-Verbindung
user_pref("browser.sessionstore.interval", 60000);

/** SECURITY ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("network.IDN_show_punycode", true);
user_pref("pdfjs.enableScripting", false);
user_pref("extensions.enabledScopes", 5);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);
user_pref("privacy.antitracking.isolateContentScriptResources", true);
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);

/** PRIVACY (rest of speculative loading, GPC) ***/
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);

/** TELEMETRY / EXPERIMENTS ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.usage.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
