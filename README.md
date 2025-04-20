```bash
if [[ -f ~/.zshrc ]]; then mv ~/.zshrc ~/.zshrc_old; fi
curl https://raw.githubusercontent.com/forkd4x/dotfiles/main/zshrc > ~/.zshrc
exec zsh
```
