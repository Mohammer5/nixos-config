# declare-option -hidden str-list sexp-form-delimiters ( ) { } [ ] \"
declare-option -hidden str sexp_opening_form_delimiters "\(|\{|\["
declare-option -hidden str sexp_element_delimiters "\(|\{|\[|\s"

# Only works when there are actually top level forms under/before the cursor
# Command explained:
#
#                  gh ==> go to beginning of line
#                   l ==> go to next character so reverse search can find
#                         the beginnign we'd otherwise be already on
#   <a-?>^($kak)<ret> ==> Search for previous occurrence of
#                         a form delimiter in the first column
#                   m ==> select the entire form
define-command sexp-select-top-level-compound-form \
  -docstring "Select top-level form under/before the cursor" \
  %{
    nop %sh{
      echo "eval -client '$kak_client' 'execute-keys 'ghl<a-?>^($kak_opt_sexp_opening_form_delimiters)<ret>m''" |
        kak -p ${kak_session}
    }
  }

define-command sexp-select-compound-form \
  -docstring "" \
  %{
    echo %sh{
      echo "eval -client '$kak_client' 'execute-keys 'l<a-?>($kak_opt_sexp_opening_form_delimiters)<ret>m''" |
        kak -p ${kak_session}
    }
  }
