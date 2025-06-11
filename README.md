```bash
if [[ -f ~/.zshrc ]]; then mv ~/.zshrc ~/.zshrc_old; fi
curl https://raw.githubusercontent.com/forkd4x/dotfiles/main/zshrc > ~/.zshrc
exec zsh

brew outdated
brew upgrade

npm outdated -g
npm update -g

zinit self-update
zinit update

nvim --headless "+MasonUpdate" "+MasonToolsUpdateSync" "+Lazy! sync" +qa
```
