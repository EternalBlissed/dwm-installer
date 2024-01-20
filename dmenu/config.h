/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Jetbrains Mono:size=11"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#cad3f5", "#24273a" },
	[SchemeSel] = { "#24273a", "#8aadf4" },
	[SchemeSelHighlight] = { "#24273a", "#cad3f5" },
	[SchemeNormHighlight] = { "#24273a", "#423554" },
	[SchemeOut] = { "#000000", "#00ffff" },
	[SchemeOutHighlight] = { "#24273a", "#cad3f5" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      =  0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
