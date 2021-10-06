
# checkout master branch
gitm() {
    local branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    git checkout $branch
    git pull
}

gitmain(){
  git checkout main
  git pull
}

# git add commit and push all in one
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

gitclean(){
    local local_branch=("${(@f)$(git branch | sed 's|* |  |' | sort)}")
    local remote_branch=("${(@f)$(git branch -r | sed 's|origin/||' | sort)}")
    local diff_list=()
    for i in "${local_branch[@]}"; do
        skip= 
        for j in "${remote_branch[@]}"; do
            [[ $i == $j ]] && { skip=1; break; }
        done
        [[ -n $skip ]] || diff_list+=("$i")
    done
    for b in "${diff_list[@]}"; do
        git branch -D $(echo $b | xargs)
    done
}

gitl(){
    local lfile=$(git branch | sed 's|* |  |' | sort)
    echo $lfile
}

gitr(){
    local rfile=$(git branch -r | sed 's|origin/||' | sort)
    echo $rfile
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
