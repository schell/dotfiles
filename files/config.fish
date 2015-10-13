#aliases
function gobang
    cd ~/code/js/bang
end
function goviewer
    cd ~/code/synapse/SYNVIEWER/trunk
end
function gocviewer
    cd ~/code/synapse/CocoaViewer
end
function la
    ls -a $argv
end
function lh
    ls -lah $argv
end
function lo
    ls -loh $argv
end
function macvim
    if not test -f $argv
        touch $argv
    end

    open -a MacVim.app $argv
end

# TMUX/VIM settings...
set TERM screen-256color-bce
set __CF_USER_TEXT_ENCODING 0x1F5:0x08000100:0

#path stuff
set PATH $HOME/.cabal/bin $PATH
set PATH /usr/local/bin $PATH
set PATH $PATH $HOME/Applications/bin
set PATH $PATH /opt/subversion/bin
set PATH $PATH /opt/local/bin
set PATH $PATH /opt/local/sbin
set PATH $PATH $HOME/bin
set PATH $PATH $HOME/Code/flow

# Haskell stuff
set GHC_DOT_APP /Applications/ghc-7.10.2.app
set GHC_DOT_APP /Applications/ghc-7.8.3.app
set PATH $HOME/.local/bin $HOME/.cabal/bin $GHC_DOT_APP/Contents/bin $PATH

function switchGHC
    set GHC_DOT_APP /Applications/ghc-$argv.app
    set PATH $HOME/.local/bin $HOME/.cabal/bin $GHC_DOT_APP/Contents/bin $PATH
    echo "Your GHC is "(which ghc)
end

switchGHC 7.8.3

# Node stuff
set PATH $PATH $HOME/Code/nvm/bin
set PATH $PATH /usr/local/share/npm/bin
set NODE_PATH /usr/local/lib/node

# nix stuff
set NIX_PATH $HOME/nixpkgs
set NIX_LINK $HOME/.nix-profile
set PATH $NIX_LINK/bin $NIX_LINK/sbin $PATH

# Add Go stuff
set GOROOT /usr/local/go
set PATH $PATH $GOROOT/bin

function gitlogdiff
    git log $argv --graph --pretty=format:'%Cred%h%Creset %d %s %Cgreen(%cr)%Creset %Cblue[%an]%Creset' --abbrev-commit --date=relative
end

function parse_git_branch
    set gitstatus (git status)
    echo $gitstatus | sed '/# On branch/g'
    #git rev-parse --git-dir &> /dev/null
    #set git_status git status 2> /dev/null
    #branch_pattern="^# On branch ([^${IFS}]*)"
    #remote_pattern="# Your branch is (.*) of"
    #diverge_pattern="# Your branch and (.*) have diverged"
end

#prompt function
function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
        set __git_cb ":"(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end


    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s%s%s%s%s$ ' $USER "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

end
