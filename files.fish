function files
  echo "$HOME/.config/fish/config.fish $HOME/.spacemacs"
end

function commitfiles
  files | xargs -J % cp % ./
  git add -A
  git commit -am "updated dotfiles"
  git push origin master
end

function putfiles
  files | xargs -J % cp % ~/
end
