######################################################
## Environment

set PAGER less
set LESS "-R"
set DOTFILES "$HOME/Projects/github/the-dr-lazy/.dotfiles"
set DOOM_DIR "$HOME/.doom.d"

if test -e $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
  set -x SSH_AUTH_SOCK $HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
end

######################################################
## Profile

status --is-login; and not set -q __fish_login_config_sourced
and begin

fish_add_path $DOTFILES/home/emacs.d/bin

if test -e $HOME/.nix-profile/etc/profile.d/nix.sh
  fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
end

set -g __fish_login_config_sourced
end

direnv hook fish | source
starship init fish | source

######################################################
## Greeting

function fish_greeting
  if not type -q fortune;
  or not type -q cowsay;
  or not type -q lolcat;
    return
  end

  set -l toon (random choice {default,dragon,dragon-and-cow,elephant,moose,stegosaurus,tux,vader})

  begin
    echo (date) " @ " (hostname)
    echo
    fortune -a -n 55 | cowsay -f $toon
  end | lolcat
end

######################################################
## Theme

set -g theme_nerd_fonts yes
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv no
set -g theme_display_nix yes
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_date no
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_date_timezone Iran/Tehran
set -g theme_color_scheme nord

function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end

function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end
