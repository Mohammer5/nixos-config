# Theme
#######

# Syntax
face global comment bright-black+i

# UI
face global Error bright-white,red
face global LineNumbers bright-black,default
face global LineNumbersWrapped bright-black,default
face global PrimaryCursor black,yellow
face global PrimaryCursorEol black,bright-cyan
face global PrimarySelection bright-white,blue
face global SecondaryCursor black,bright-black
face global SecondaryCursorEol black,cyan
face global SecondarySelection black,blue

# Dim inactive
##############

face global InactiveHighlight white,bright-black

hook global WinDisplay .* %{
  face window PrimaryCursor PrimaryCursor
  face window PrimaryCursorEol PrimaryCursorEol
  face window SecondaryCursor SecondaryCursor
  face window SecondaryCursorEol SecondaryCursorEol
  face window LineNumberCursor LineNumberCursor
  face window PrimarySelection PrimarySelection
  face window SecondarySelection SecondarySelection
  face window Information Information
}

hook global FocusIn .* %{
  face window PrimaryCursor PrimaryCursor
  face window PrimaryCursorEol PrimaryCursorEol
  face window SecondaryCursor SecondaryCursor
  face window SecondaryCursorEol SecondaryCursorEol
  face window LineNumberCursor LineNumberCursor
  face window PrimarySelection PrimarySelection
  face window SecondarySelection SecondarySelection
  face window Information Information
}

hook global FocusOut .* %{
  face window PrimaryCursor InactiveHighlight
  face window PrimaryCursorEol InactiveHighlight
  face window SecondaryCursor InactiveHighlight
  face window SecondaryCursorEol InactiveHighlight
  face window LineNumberCursor InactiveHighlight
  face window PrimarySelection InactiveHighlight
  face window SecondarySelection InactiveHighlight
  face window Information InactiveHighlight
}

# Dim lint
##########

face global LintError red,default
face global LintWarning yellow,default

define-command -hidden -override lint-show-counters %{
  echo -markup "linting results: {LintError}%opt{lint_error_count} error(s) {LintWarning}%opt{lint_warning_count} warning(s)"
}
