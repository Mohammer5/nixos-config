# text object selection
# ─────────────────────
define-command sexp-select-top-level-compound-form -docstring "" %{
  nop %sh{
    if [[ $kak_cursor_column -eq 1 ]] && [[ $kak_selection = "(" ]]
    then
      echo "eval -client '$kak_client' 'execute-keys 'm''" |
        kak -p ${kak_session}
    else
      echo "eval -client '$kak_client' 'execute-keys '<a-?>^\(<ret>m''" |
        kak -p ${kak_session}
    fi
  }
}
define-command sexp-select-compound-form -docstring "" %{}

# Can be done with <a-i>"/<a-a>"
# define-command sexp-select-string -docstring "" %{}

# Can be done with <a-a>w
# define-command sexp-select-element -docstring "" %{}

# text object motions
# ───────────────────
define-command sexp-move-the-cursor-to-the-nearest-paired-structural-bracket-next -docstring "" %{}
define-command sexp-move-the-cursor-to-the-nearest-paired-structural-bracket-prev -docstring "" %{}
define-command sexp-move-the-cursor-to-element-head-next -docstring "" %{}
define-command sexp-move-the-cursor-to-element-head-prev -docstring "" %{}
define-command sexp-move-the-cursor-to-element-tail-next -docstring "" %{}
define-command sexp-move-the-cursor-to-element-tail-prev -docstring "" %{}
define-command sexp-move-the-cursor-to-an-adjacent-top-level-element-next -docstring "" %{}
define-command sexp-move-the-cursor-to-an-adjacent-top-level-element-prev -docstring "" %{}
define-command sexp-move-the-cursor-to-the-adjacent-element-next -docstring "" %{}
define-command sexp-move-the-cursor-to-the-adjacent-element-prev -docstring "" %{}

# indent commands
# ───────────────
define-command sexp-indent-the-current-compound-form-without-moving-the-cursor -docstring "" %{}
define-command sexp-indent-the-current-top-level-compound-form-without-moving-the-cursor -docstring "" %{}

# wrap commands
# ─────────────
define-command sexp-wrap-the-current-compound-form-with-parenthesis-open -docstring "" %{}
define-command sexp-wrap-the-current-compound-form-with-parenthesis-close -docstring "" %{}
define-command sexp-wrap-the-current-compound-form-with-brackets-open -docstring "" %{}
define-command sexp-wrap-the-current-compound-form-with-brackets-close -docstring "" %{}
define-command sexp-wrap-the-current-compound-form-with-braces-open -docstring "" %{}
define-command sexp-wrap-the-current-compound-form-with-braces-close -docstring "" %{}
define-command sexp-wrap-the-current-element-with-parenthesis-open -docstring "" %{}
define-command sexp-wrap-the-current-element-with-parenthesis-close -docstring "" %{}
define-command sexp-wrap-the-current-element-with-brackets-open -docstring "" %{}
define-command sexp-wrap-the-current-element-with-brackets-close -docstring "" %{}
define-command sexp-wrap-the-current-element-with-braces-open -docstring "" %{}
define-command sexp-wrap-the-current-element-with-braces-close -docstring "" %{}

# list manipulation
# ─────────────────
define-command sexp-splice-the-current-compound-form-into-its-parent. -docstring "" %{}
define-command sexp-raise-the-current-compound-form-to-replace-the-enclosing-compound-form. -docstring "" %{}
define-command sexp-raise-the-current-element-to-replace-the-enclosing-compound-form. -docstring "" %{}
define-command sexp-swap-the-position-of-the-current-compound-form-with-the-previous-sibling-element. -docstring "" %{}
define-command sexp-swap-the-position-of-the-current-compound-form-with-the-next-sibling-element. -docstring "" %{}
define-command sexp-swap-the-position-of-the-current-element-with-the-previous-sibling-element. -docstring "" %{}
define-command sexp-swap-the-position-of-the-current-element-with-the-next-sibling-element. -docstring "" %{}
# <M-S-j> and <M-S-k> emit the terminal elements of the current COMPOUND FORM.
# <M-S-h> and <M-S-l> capture adjacent elements into the current COMPOUND FORM.

# cursor insertion
# ────────────────
define-command sexp-insert-the-cursor-at-the-head-of-the-current-compound-form -docstring "" %{}
define-command sexp-insert-the-cursor-at-the-tail-of-the-current-compound-form -docstring "" %{}

# insert mode mappings
# ────────────────────
define-command sexp-produce-a-closing-parenthesis-and-also-insert-spaces-as-necessary-to-separate-the-new-compound-form-from-adjacent-non-compound-elements. -docstring "" %{}
define-command sexp-produce-a-closing-bracket-and-also-insert-spaces-as-necessary-to-separate-the-new-compound-form-from-adjacent-non-compound-elements. -docstring "" %{}
define-command sexp-produce-a-closing-brace-and-also-insert-spaces-as-necessary-to-separate-the-new-compound-form-from-adjacent-non-compound-elements. -docstring "" %{}
define-command sexp-insert-closing-parenthesiss-when-the-corresponding-opening-parenthesis-is-unpaired.-If-the-opening-parenthesis-is-paired,-jump-to-the-next-paired-instance-of-the-closing-parenthesis. -docstring "" %{}
define-command sexp-insert-closing-brackets-when-the-corresponding-opening-bracket-is-unpaired.-If-the-opening-bracket-is-paired,-jump-to-the-next-paired-instance-of-the-closing-bracket. -docstring "" %{}
define-command sexp-insert-closing-braces-when-the-corresponding-opening-brace-is-unpaired.-If-the-opening-brace-is-paired,-jump-to-the-next-paired-instance-of-the-closing-brace. -docstring "" %{}
define-command sexp-insert-a-pair-of-double-quotes,-unless-the-cursor-is-currently-in-a-string. -docstring "" %{}
define-command sexp-delete-an-adjacent-pair-of-(),-[],-{},-and-""-when-deleting-the-opening-bracket-or-quote.-Normal-backspace-otherwise. -docstring "" %{}
