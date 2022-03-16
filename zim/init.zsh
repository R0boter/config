zimfw() { source ~/.config/zim/zimfw.zsh "${@}" }
fpath=(~/.config/zim/modules/git/functions ~/.config/zim/modules/utility/functions ~/.config/zim/modules/git-info/functions ${fpath})
autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw coalesce git-action git-info
source ~/.config/zim/modules/environment/init.zsh
source ~/.config/zim/modules/git/init.zsh
source ~/.config/zim/modules/input/init.zsh
source ~/.config/zim/modules/termtitle/init.zsh
source ~/.config/zim/modules/utility/init.zsh
source ~/.config/zim/modules/sorin/sorin.zsh-theme
source ~/.config/zim/modules/zsh-completions/zsh-completions.plugin.zsh
source ~/.config/zim/modules/completion/init.zsh
source ~/.config/zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
