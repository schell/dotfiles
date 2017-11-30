function files
  echo "~/.config/fish/config.fish ~/.spacemacs"
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
