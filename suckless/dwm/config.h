/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "mono:pixelsize=16:antialias=true:autohint=true" };
static const char dmenufont[]       = "mono:pixelsize=16:antialias=true:autohint=true";
static const char col_norm_bg[]     = "#1d2021";
static const char col_norm_fg[]     = "#ebdbb2";
static const char col_norm_bd[]     = "#1d2021";
static const char col_sel_bg[]      = "#689d6a";
static const char col_sel_fg[]      = "#1d2021";
static const char col_sel_bd[]      = "#689d6a";
static const char *colors[][3]      = {
	/*               fg           bg           border      */
	[SchemeNorm] = { col_norm_fg, col_norm_bg, col_norm_bd },
	[SchemeSel]  = { col_sel_fg,  col_sel_bg,  col_sel_bd  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class               instance  title    mask    isfloating  monitor */
	{ "Firefox",           NULL,     NULL,    1 << 0, 0,          -1 },
	{ "qutebrowser",       NULL,     NULL,    1 << 0, 0,          -1 },
	{ "Thunderbird",       NULL,     NULL,    1 << 1, 0,          -1 },
	{ "discord",           NULL,     NULL,    1 << 1, 0,          -1 },
	{ "TelegramDesktop",   NULL,     NULL,    1 << 1, 0,          -1 },
	{ "Chromium-browser",  NULL,     NULL,    1 << 3, 0,          -1 },
	{ "jetbrains-idea",    NULL,     NULL,    1 << 3, 0,          -1 },
	{ "jetbrains-pycharm", NULL,     NULL,    1 << 3, 0,          -1 },
	{ "mpv",               NULL,     NULL,    1 << 6, 0,          -1 },
	{ "vlc",               NULL,     NULL,    1 << 6, 0,          -1 },
	{ "st-256color",       NULL,     "cmus",  1 << 7, 0,          -1 },
	{ "Virt-manager",      NULL,     NULL,    1 << 8, 0,          -1 },
	{ "scratchpad",        NULL,     NULL,    0,      1,          -1 },
	{ "calculator",        NULL,     NULL,    0,      1,          -1 },
};

/* layout(s) */
static const float mfact     = 0.5;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_norm_bg, "-nf", col_norm_fg, "-sb", col_sel_bg, "-sf", col_sel_fg, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *scratchpadcmd[] = { "termlaunch", "scratchpad", NULL };
static const char *calculatorcmd[] = { "termlaunch", "calculator", NULL };
static const char *notescmd[] = { "termlaunch", "-n", "~/notes/todos/tasks.org", "notes", NULL };
static const char *resolutioncmd[] = { "refreshresolution", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY,                       XK_g,      spawn,          {.v = scratchpadcmd } },
	{ MODKEY,                       XK_c,      spawn,          {.v = calculatorcmd } },
	{ MODKEY,                       XK_n,      spawn,          {.v = notescmd } },
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = resolutioncmd } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

