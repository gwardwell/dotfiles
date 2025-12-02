# Shortcut to zsh config
alias config='code ~/.zshrc'

# Shortcut to my custom zsh aliases file
alias aliases='code $ZSH_CUSTOM/aliases.zsh'

# Directory shortcuts
alias desktop='open ~/Desktop'
alias downloads='open ~/Downloads'
alias lib='open ~/Library'
alias sites='cd ~/Sites'
alias dev='cd ~/Developer'
alias personal='cd ~/Developer/personal'

# Helper shortcuts
alias nodenv-update='brew upgrade nodenv node-build'

# Check if 'code' command exists, if not, alias it to 'cursor'
if ! command -v code &> /dev/null; then
    alias code=cursor
fi

# Git
alias adda='git add .'
alias bisect='git bisect'
alias bisect_bad='git bisect bad'
alias bisect_good='git bisect good'
alias bisect_reset='git bisect reset'
alias bisect_start='git bisect start'
alias branch='git checkout -b'
alias checkout='git checkout'
alias commit='git commit'
alias commitam='git commit --amend'
alias delete_branch='git branch -d'
alias diff='git diff'
alias fetch='git fetch --all --prune'
alias forget='git rm --cached -r'
alias merge='git merge'
alias mergea='git merge --abort'
alias mergec='git merge --continue'
# alias push='git push --force-with-lease'
alias pull='git pull'
alias rebasea='git rebase --abort'
alias rebasec='git rebase --continue'
alias reset='git reset --hard'
alias stash='git stash -u'
alias stash_clear='git stash clear'
alias stash_list='git stash list'
alias stash_show='git stash show'
alias stats='git status'
alias unstash='git stash pop'
alias main='checkout main'
alias merge_main='merge origin/main'

# Clone a repo (can be overridden in aliases-employer.zsh for multi-account setups)
alias clone='git clone'

# Catch an exception.  Returns 0 if the exception in question was caught.
# The first argument gives the exception to catch, which may be a
# pattern.
# This must be within an always-block.  A typical set of handlers looks
# like:
#   {
#     # try block; something here throws exceptions
#   } always {
#      if catch MyExcept; then
#         # Handler code goes here.
#         print Handling exception MyExcept
#      elif catch *; then
#         # This is the way to implement a catch-all.
#         print Handling any other exception
#      fi
#   }
# As with other languages, exceptions do not need to be handled
# within an always block and may propagate to a handler further up the
# call chain.
#
# It is possible to throw an exception from within the handler by
# using "throw".
#
# The shell variable $CAUGHT is set to the last exception caught,
# which is useful if the argument to "catch" was a pattern.
#
# Use "function" keyword in case catch is already an alias.
function catch {
  print $TRY_BLOCK_ERROR
  print $EXCEPTION
  if [[ $TRY_BLOCK_ERROR -gt 0 && $EXCEPTION = ${~1} ]]; then
    print 'TRY_BLOCK_ERROR'
    (( TRY_BLOCK_ERROR = 0 ))
    typeset -g CAUGHT="$EXCEPTION"
    unset EXCEPTION
    return 0
  fi

  return 1
}

# Never use globbing with "catch".
alias catch="noglob catch"

function commita () {
    adda;
    commit $argv;
}

function fetchb () {
    git fetch origin $argv:$argv
}

function fix-unstash-conflict () {
    git reset;
    git stash drop;
}

function rebase () {
    fetchb $argv
    git rebase -i $argv
}

function push () {
  current_branch=$(git branch --show-current 2>&1)
  result=$(git push --force-with-lease 2>&1)
  if [[ $result == "fatal: The current branch $current_branch has no upstream branch."* ]]; then
    print "No upstream branch '$current_branch'. Pushing upstream."
    git push -u origin $current_branch
  else
    print $result
  fi
}

# Diff two files with good coloring
# Example:
#   gdiff filea fileb
gdiff='git diff --no-index --word-diff --color-words'

# Opens the GitHub PR for the current branch
function opr() {
  local branch_name=$(git branch --show-current)
  local pr_url=$(gh pr list --head "$branch_name" --state open --limit 1 --json url --jq '.[0].url')
  if [[ -z "$pr_url" ]]; then
    echo "No open pull requests found for branch '$branch_name'."
    return 1
  fi
  open "$pr_url"
}
