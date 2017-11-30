function files
  echo "~/.config/fish/config.fish ~/.spacemacs"
end

function commitfiles
  cp (files) ./
  git add -A
  git commit -am "updated dotfiles"
  get push origin master
end

function putfiles
  cp (files) ~/
end
