
# checkout master branch
gitm() {
    git checkout master
    git pull
}


gitall() {
    git add .
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        git commit -m "$1"
    else
        local mx=$(git status --porcelain)
        git commit -m mx
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin "$branch"
}

gitb() {
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        git checkout -b "$1"
    else
    	local frd=$(date +%d.%m.%y-%s)
        git checkout -b "feature-$frd"
    fi
}


alias gitclean="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D" 