export EDITOR="kak"
export FZF_DEFAULT_COMMAND="rg --hidden -l "" -g '!.git/'"

# Cypress development
# export NODE_OPTIONS="--openssl-legacy-provider"
if command -v Cypress >/dev/null 2>&1; then
    export CYPRESS_RUN_BINARY="$(command -v Cypress)"
fi
