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

# Haskell stuff 
set PATH $PATH $HOME/Library/Haskell/bin

# Node stuff
set PATH $PATH $HOME/Code/nvm/bin
set PATH $PATH /usr/local/share/npm/bin
set NODE_PATH /usr/local/lib/node



# Add Go stuff
set GOROOT /usr/local/go
set PATH $PATH $GOROOT/bin

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
        set __git_cb ":"(set_color cyan)(set_color -b black)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

        case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
        
        case 'schellsan'
            
        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        printf '%s%s%s%s> ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
        
        case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

        printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end
