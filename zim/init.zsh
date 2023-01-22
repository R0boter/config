zimfw() { source /root/.config/zim/zimfw.zsh "${@}" }
fpath=(/root/.config/zim/modules/utility/functions /root/.config/zim/modules/prompt-pwd/functions /root/.config/zim/modules/git-info/functions ${fpath})
autoload -Uz mkcd mkpw prompt-pwd coalesce git-action git-info
source /root/.config/zim/modules/environment/init.zsh
source /root/.config/zim/modules/input/init.zsh
source /root/.config/zim/modules/termtitle/init.zsh
source /root/.config/zim/modules/utility/init.zsh
source /root/.config/zim/modules/sorin/sorin.zsh-theme
source /root/.config/zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /root/.config/zim/modules/completion/init.zsh
source /root/.config/zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /root/.config/zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /root/.config/zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
