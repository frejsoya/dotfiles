#GIT aware prompt
#PS1='\h:\W$(__git_ps1 "(%s)") \u\$ '

complete -F _known_hosts mosh

#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

GIT_PROMPT_ONLY_IN_REPO=1

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
  GIT_PROMPT_THEME=Solarized
  source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

#source ~/Projects/bash-git-prompt/gitprompt.sh

#[[ $- == *i* ]]   &&   . ~/Projects/git-prompt/git-prompt.sh

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

#if [ -f /usr/local/etc/bash_completion ]; then
#  . /usr/local/etc/bash_completion
#fi
export HOMEBREW_PREFIX="/usr/local"
export XDG_DATA_DIRS="$HOMEBREW_PREFIX/share"
export XDG_CONFIG_DIRS="$HOMEBREW_PREFIX/etc"
export XDG_CONFIG_HOME="$HOME/.config"
export GSETTINGS_SCHEMA_DIR="$HOMEBREW_PREFIX/etc/glib-2.0/schemas"
export GTK_DATA_PREFIX="$HOMEBREW_PREFIX"
export GTK_EXE_PREFIX="$HOMEBREW_PREFIX"
export GTK_PATH="$HOMEBREW_PREFIX"
export PANGO_LIBDIR="$HOMEBREW_PREFIX/lib"
export PANGO_SYSCONFDIR="$HOMEBREW_PREFIX/etc"
export GDK_PIXBUF_MODULEDIR="$HOMEBREW_PREFIX/lib/gdk-pixbuf-2.0/2.10.0/loaders"
export GDK_PIXBUF_MODULE_FILE="$HOMEBREW_PREFIX/etc/gtk-2.0/gdk-pixbuf.loaders"

export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

export PATH=/usr/local/share/npm/bin:/users/frej/mosml/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/ruby/1.9.3-p194/bin:/opt/local/bin:/opt/local/sbin:/usr/texbin/:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

#Ensure gnuutils version because of issuu work. (Will break all kinds of standard osx stuff..)
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# For gobject-introspection to find our homebrew-installed ".typelib" files:
export GI_TYPELIB_PATH=/usr/local/lib/girepository-1.0

#virtualenv
export WORKON_HOME=$HOME/Envs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute --no-site-packages'

export EDITOR=mvim


pman () {
    man -t "${1}" | open -f -a /Applications/Skim.app
}

#switch jdk to 1.7 as default
export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
setjdk() {
      export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

export LC_ALL=da_DK.UTF-8 
export LANG=da_DK.UTF-8

##append instead of rewrite 
shopt -s histappend

###Various aliases
alias build="/usr/bin/make -j 8"
alias ls="ls --color=auto"
export CLICOLOR=1
#PROMPT_COMMAND=$PROMPT_COMMAND';history -a;history -n'

shopt -s globstar autocd
#
complete -C aws_completer aws

# OPAM configuration
eval `opam config env`
. /Users/frej/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/frej/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"

#anoying issuu stuff
export AGGREGATOR_CONF_SHADOW=

#
export PATH=$HOME/.local/bin:$PATH

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash

#To use Homebrew's directories rather than ~/.pyenv:
export PYENV_ROOT=/usr/local/var/pyenv
#pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#pyenv virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


complete -C aws_completer aws
