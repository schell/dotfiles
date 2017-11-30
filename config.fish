#path
set -x PATH $PATH ~/Dropbox/code/ghc-ios-scripts ~/.local/bin ~/.cargo/bin /Applications/Postgres.app/Contents/Versions/9.6/bin /usr/local/opt/llvm@5/bin

set -x NIX_CONF_DIR /Users/schell/.nix/conf

#aliases
function la
    ls -a $argv
end

function myemacs
    open /usr/local/Cellar/emacs-mac/emacs-25.1-z-mac-6.1/Emacs.app
end

function lh
    ls -lah $argv
end

function timeclocktime
  date '+%Y-%m-%d %H:%M:%S'
end

function clockprompt
  set_color green
  echo -n $argv[1]
  set_color normal
  echo '> '
end

function accprompt
  clockprompt "account"
end

function descprompt
  clockprompt "description"
end

function clockin
  echo "clocking IN: $argv[1]"
  set TIME (timeclocktime)
  read -p accprompt  -l ACCT
  read -p descprompt -l DESC
  set LINE "i $TIME $ACCT  $DESC"
  echo "clocking in this line:"
  echo "--------------------------------------------------------------------------------"
  echo $LINE
  echo "--------------------------------------------------------------------------------"
  echo "hit return to confirm, ctrl-c to cancel"
  read -p "clockprompt confirm" CONF
  echo $LINE >> $argv[1]
  echo "clocked in"
end

function clockout
  echo "clocking OUT: $argv[1]"
  set TIME (timeclocktime)
  set INPUTLINE (cat $argv[1] | tail -n1)
  set ACCT (echo $INPUTLINE | cut -d ' ' -f 4- | grep -o '^.*  ')
  set LINE "o $TIME $ACCT"
  echo "clocking out this line:"
  echo "--------------------------------------------------------------------------------"
  echo $LINE
  echo "--------------------------------------------------------------------------------"
  echo "hit return to confirm, ctrl-c to cancel"
  read -p "clockprompt confirm" CONF
  echo $LINE >> $argv[1]
  echo "clocked out"
end

function lo
    ls -loh $argv
end

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
