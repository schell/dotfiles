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
    ls -a
end
function lh
    ls -lah
end

# xcodebuild helper
function xcodebuildup
    function hereOrUp
        if test -d usr
            echo "error:could not find xcodeproj"
        else
            if test -d *.xcodeproj
                echo -n "found xcodeproj at "
                pwd
                xcodebuild
            else
                echo ".."
                cd ..
                hereOrUp
            end
        end
    end

    set OWD (pwd)
    hereOrUp
    cd $OWD
end

# Android SDK location...
function android
    ~/code/android/android-sdk-macosx/tools/android $argv
end

# TMUX/VIM settings...
set TERM screen-256color-bce
set __CF_USER_TEXT_ENCODING 0x1F5:0x08000100:0
#path stuff
set EDITOR $HOME/bin/mate -w
set PATH /usr/local/bin $PATH
# MacPorts Installer addition on 2009-12-17_at_17:22:31: adding an appropriate PATH variable for use with MacPorts.
set PATH $PATH $HOME/.gem/ruby/1.8/bin 
set PATH $PATH $HOME/Applications/bin 
set PATH $PATH /opt/subversion/bin 
set PATH $PATH /opt/local/bin  
set PATH $PATH /opt/local/sbin  
set PATH $PATH $HOME/bin  
set PATH $PATH /Applications/MAMP/bin/php5.3/bin  
set PATH $PATH /Applications/MAMP/Library/bin
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2010-10-10_at_13 45 22  adding an appropriate PATH variable for use with MacPorts.
set PATH $PATH /opt/local/bin  
set PATH $PATH /opt/local/sbin  
set PATH $PATH /SDKs/Flex/bin

# Add Haskell userspace bin
set PATH $PATH $HOME/Library/Haskell/bin

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

#search string
function gstring 
    grep -r "$argv" src > grep; vim grep; rm grep
end
