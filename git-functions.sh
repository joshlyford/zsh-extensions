
# checkout master branch
gitm() {
    git checkout master
    git pull
}


gitall() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    git add .
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        git commit -m "$1"
    else
        #local mx=$(git status --porcelain)
        local mx=$(date +%d.%m.%y)
        git commit -m "Update $branch $mx"
    fi
    git push --set-upstream origin "$branch"
}

gitb() {
    local prefix=""
    if [ $ZSHE_USER ]
    then
        prefix="$ZSHE_USER/"
    fi

    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then    
        git checkout -b "${prefix}feature-$1"
    else
    	local frd=$(date +%d.%m.%y-%s)
        git checkout -b "${prefix}feature-$frd"
    fi
}


alias gitclean="git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D" 