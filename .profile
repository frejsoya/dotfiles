
test -r /sw/bin/init.sh && . /sw/bin/init.sh
#GIT aware prompt
#PS1='\h:\W$(__git_ps1 "(%s)") \u\$ '
[[ $- == *i* ]]   &&   . ~/Projects/git-prompt/git-prompt.sh


if [ -f /opt/local/etc/bash_completion ]; then
   . /opt/local/etc/bash_completion
fi

export PATH=/usr/local/Cellar/ruby/1.9.2-p0/bin:/users/frej/mosml/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/python/2.7/bin:/opt/local/bin:/opt/local/sbin:/usr/texbin/:$PATH

export MANPATH=/opt/local/share/man:$MANPATH

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi


#virtualenv
export WORKON_HOME=$HOME/Envs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute --no-site-packages'

export EDITOR=mvim


