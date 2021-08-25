import os


# Load autoconfig.
config.load_autoconfig()

# Always restore open sites when qutebrowser is reopened.
c.auto_save.session = True

# Backend to use to display websites.
c.backend = "webengine"

# Tell websites that a dark colorscheme is preferred.
c.colors.webpage.preferred_color_scheme = "dark"

# Shrink the completion to be smaller than the configured size
# if there are no scrollbars.
c.completion.shrink = True

# Automatically start playing `<video>` elements.
c.content.autoplay = False

# List of URLs to ABP-style adblocking rulesets.
c.content.blocking.adblock.lists = [
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://curben.gitlab.io/malware-filter/urlhaus-filter-online.txt",
    "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt",
    "https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/AnnoyancesFilter/sections/annoyances.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://raw.githubusercontent.com/tomasko126/easylistczechandslovak/master/filters.txt",
    "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_1_Russian/filter.txt",
    "https://www.fanboy.co.nz/fanboy-problematic-sites.txt",
    "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/nocoin.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
]

# Enable the ad/host blocker
c.content.blocking.enabled = True

# Which method of blocking ads should be used.
c.content.blocking.method = "adblock"

# Which cookies to accept.
c.content.cookies.accept = "no-3rdparty"

# Default encoding to use for websites.
c.content.default_encoding = "utf-8"

# Allow websites to share screen content.
c.content.desktop_capture = "ask"

# Allow websites to request geolocations.
c.content.geolocation = False

# When to send the Referer header.
c.content.headers.referer = "same-domain"

# Allow JavaScript to read from or write to the clipboard.
c.content.javascript.can_access_clipboard = False

# Allow JavaScript to open new tabs without user interaction.
c.content.javascript.can_open_tabs_automatically = False

# Enable JavaScript.
c.content.javascript.enabled = True

# Allow websites to lock your mouse pointer.
c.content.mouse_lock = False

# Allow pdf.js to view PDF files in the browser.
c.content.pdfjs = False

# Prompt the user for the download location.
c.downloads.location.prompt = True

# What to display in the download filename input (both = download path & filename).
c.downloads.location.suggestion = "both"

# Editor (and arguments) to use for the `edit-*` commands.
c.editor.command = [
    os.environ["TERMINAL"],
    "-e",
    os.environ["EDITOR"],
    "-f",
    "{file}",
    "-c",
    "set cc=|normal {line}G{column0}l",
]

# Make characters in hint strings uppercase.
c.hints.uppercase = True

# Level for console (stdout/stderr) logs.
c.logging.level.console = "critical"

# Level for in-memory logs.
c.logging.level.ram = "critical"

# Enable smooth scrolling for web pages.
c.scrolling.smooth = True

# When to find text on a page case-insensitively.
c.search.ignore_case = "smart"

# Find text on a page incrementally, renewing the search for each typed character.
c.search.incremental = True

# Switch between tabs using the mouse wheel.
c.tabs.mousewheel_switching = False

# Open URLs from the terminal in new tabs.
c.new_instance_open_target = "tab"

# Position of new tabs opened from another tab.
c.tabs.new_position.related = "next"

# Stack related tabs on top of each other when opened consecutively.
c.tabs.new_position.stacking = True

# Position of new tabs which are not opened from another tab.
c.tabs.new_position.unrelated = "last"

# Which tab to select when the focused tab is removed.
c.tabs.select_on_remove = "last-used"

# Format to use for the tab title.
c.tabs.title.format = "{audio}: {current_title}"

# Format to use for the tab title for pinned tabs.
c.tabs.title.format_pinned = "{current_title}"

# Page to open if :open -t/-b/-w is used without URL.
c.url.default_page = "about:blank"

# Open base URL of the searchengine if a searchengine shortcut
# is invoked without parameters.
c.url.open_base_url = True

# Search engines which can be used via the address bar.
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "w": "https://en.wikipedia.org/wiki/Special:Search/{}",
    "y": "https://www.youtube.com/results?search_query={}",
    "r": "https://www.reddit.com/search?q={}",
    "gh": "https://github.com/search?q={}",
    "http": "https://httpstatuses.com/{}",
    "m": "https://www.metal-archives.com/search?type=band_name&searchString={}",
    "tce": "https://www.deepl.com/translator#cs/en/{}",
    "tec": "https://www.deepl.com/translator#en/cs/{}",
    "py": "https://docs.python.org/3/search.html?q={}",
    "aw": "https://wiki.archlinux.org/index.php?search={}",
}

# Keybindings.
config.bind(",f", "spawn -d firefox {url}")
config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")

# Load a colorscheme.
config.source("colorscheme.py")


# TODO: Autoclear cache upon exit.
