#! /bin/zsh
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' prompt 'correct %e errors'
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
#cache completions
zstyle ':completion::complete:*' use-cache 1

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
# append command to history file once executed
setopt inc_append_history

setopt autocd extendedglob nomatch
unsetopt beep notify

# vi editing
bindkey -v

export   PATH=$HOME/.bin:/opt/local/bin:/opt/local/sbin:/opt/local/apache2/bin:/usr/X11R6/bin:/usr/local/mysql/bin:$PATH:/usr/local/bin:/opt/local/libexec/git-core:$HOME/.gem/ruby/1.8/bin:/usr/local/share/python:/usr/local/share/npm/bin
export   NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
export   MANPATH=/opt/local/share/man:/opt/local/man:/usr/share/export MANPATH=/opt/local/share/man:/opt/local/man:/usr/share/man:/usr/local/share/man
export   VISUAL=vim
export   CLICOLOR=1
export   PYTHONPATH=/usr/local/lib/python2.4/site-packages
unsetopt BG_NICE
setopt   AUTO_LIST
setopt   CHASE_LINKS
setopt   NUMERIC_GLOB_SORT
setopt   PRINT_EXIT_VALUE
export   SVN_EDITOR=vi
export   PATH="$HOME/.bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export   TM_RUBY=/opt/local/bin/ruby
export   EDITOR=vim

alias    sha1sum=gsha1sum
alias    @=$EDITOR
if ls -F --color=auto >&/dev/null; then
  alias  ls="ls --color=auto -F"
else
  alias  ls="ls -F"
fi
alias    ll="ls -l"
alias    l.='ls -d .[^.]*'
alias    lsd='ls -ld *(-/DN)'
alias    ..='cd ..'
alias    vim='/usr/local/bin/vim'
alias    vi=vim
alias    cls="clear"
alias    ps="ps waux"
alias    mem='killall memcached; memcached -d -m 32 -l 127.0.0.1 -p 11211'
alias    current='cd ~/Code/kickstarter/'
alias    test_js="rake test:javascript; rake test:javascript_lint"
alias    mpc="MPD_HOST='jukebox.local' mpc"
checkout_with_migrations () {
  rake db:rollback_to_common branch=$1;
  git checkout -m $1 && rake db:migrate;
}

# rails functions and aliases
be () {
  bundle exec $@;
}
ss () {
  if [ -e script/rails ]; then be rails server -u $@; else be script/server -u $@; fi
}
sc () {
  if [ -e script/rails ]; then be rails console $@; else be script/console $@; fi
}
sg () {
  if [ -e script/rails ]; then be rails generate $@; else be script/generate $@; fi
}
sr () {
  if [ -e script/rails ]; then be rails runner $@; else be script/runner $@; fi
}
db () {
  if [ -e script/rails ]; then be rails dbconsole "$@"; else be script/dbconsole -p "$@"; fi
}
ts () {
  be thin start --debug $@;
}

do_cap () {
   if [ -e Gemfile ]; then
    bundle exec cap $@
  else
    cap $@
  fi
}
alias cap='do_cap'

# Mac specific stuff
export LSCOLORS=gxfxcxexdxbebgdbdfgfge
alias  apache4ctl="sudo /opt/local/apache2/bin/apachectl"


# _why's majik screen titles
# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

# rake autocompletion from:
# http://weblog.rubyonrails.org/2006/3/9/fast-rake-task-completion-for-zsh
_rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(stat -f%m .rake_tasks)
    changed=$(stat -f%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

_rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake
if [[ -x `which git` ]]; then
	alias g=git
	function git-branch-name () {
		git branch 2> /dev/null | grep '^\*' | sed 's/^\*\ /:/'
	}
	function git-dirty () {
		git status 2> /dev/null | grep "nothing to commit (working directory clean)"
		echo $?
	}
	function gsrb () {
		branch=$(git-branch-name)
		git checkout master
		git svn rebase
		git checkout "${branch}"
		git rebase master
	}
	function git-prompt() {
		gstatus=$(git status 2> /dev/null)
		branch=$(echo $gstatus | head -1 | sed 's/^# On branch //')
		dirty=$(echo $gstatus | sed 's/^#.*$//' | tail -2 | grep 'nothing to commit (working directory clean)'; echo $?)
		if [[ x$branch != x ]]; then
			dirty_color=$fg[cyan]
			if [[ $dirty = 1 ]] { dirty_color=$fg[magenta] }
			[ x$branch != x ] && echo " %{$dirty_color%}$branch%{$reset_color%} "
		fi
	}
	function git-scoreboard () {
		git log | grep Author | sort | uniq -ci | sort -r
	}
	function git-track () {
		branch=$(git-branch-name)
		git config branch.$branch.remote origin
		git config branch.$branch.merge refs/heads/$branch
		echo "tracking origin/$tracking"
	}
	function github-init () {
		git config branch.$(git-branch-name).remote origin
		git config branch.$(git-branch-name).merge refs/heads/$(git-branch-name)
	}

	function github-url () {
		git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'
	}

	# Seems to be the best OS X jump-to-github alias from http://tinyurl.com/2mtncf
	function github-go () {
		open $(github-url)
	}

	function nhgk () {
		nohup gitk --all &
	}
fi


setopt prompt_subst
PROMPT='%~`git-branch-name`$ '

export LANG=en_US.UTF-8

#ree garbage collection
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
