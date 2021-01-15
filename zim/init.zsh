zimfw() { source /home/falcon/.config/zim/zimfw.zsh "${@}" }
fpath=(/home/falcon/.config/zim/modules/git/functions /home/falcon/.config/zim/modules/utility/functions /home/falcon/.config/zim/modules/git-info/functions ${fpath})
autoload -Uz git-alias-lookup git-branch-current git-branch-delete-interactive git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw coalesce git-action git-info
source /home/falcon/.config/zim/modules/environment/init.zsh
source /home/falcon/.config/zim/modules/git/init.zsh
source /home/falcon/.config/zim/modules/input/init.zsh
source /home/falcon/.config/zim/modules/termtitle/init.zsh
source /home/falcon/.config/zim/modules/utility/init.zsh
source /home/falcon/.config/zim/modules/gitster/gitster.zsh-theme
source /home/falcon/.config/zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /home/falcon/.config/zim/modules/completion/init.zsh
source /home/falcon/.config/zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/falcon/.config/zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/falcon/.config/zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
