zimfw() { source /root/.config/zim/zimfw.zsh "${@}" }
fpath=(/root/.config/zim/modules/git/functions /root/.config/zim/modules/utility/functions /root/.config/zim/modules/git-info/functions ${fpath})
autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw coalesce git-action git-info
source /root/.config/zim/modules/environment/init.zsh
#source /root/.config/zim/modules/git/init.zsh
source /root/.config/zim/modules/input/init.zsh
source /root/.config/zim/modules/termtitle/init.zsh
source /root/.config/zim/modules/utility/init.zsh
source /root/.config/zim/modules/sorin/sorin.zsh-theme
source /root/.config/zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /root/.config/zim/modules/completion/init.zsh
source /root/.config/zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /root/.config/zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /root/.config/zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
