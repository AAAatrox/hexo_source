if [ "$1"x = x ]
then
  echo "\033[1;31mEXAMPLE\033[0m"
  echo "\033[1;35mhave param 1 for git commit:\033[0m"
  echo "\033[1;36m  zsh my_update.sh first\033[0m"
  echo "\033[1;35mparam 2 is longer than 1 for push to repository:\033[0m"
  echo "\033[1;36m  zsh my_update.sh first 1\033[0m"
  echo "\033[1;35mparam 2 is longer than 2 for hexo deployment:\033[0m"
  echo "\033[1;36m  zsh my_update.sh first 12\033[0m"
else
  zsh source/_posts/my_sort.sh
  echo "\033[1;32mAdding...\033[0m"
  git add my_update.sh
  git add _config.yml
  git add package.json
  git add source
  git commit -m $1

  if [ ${#2} -ge 1 ]
  then
    echo "\033[1;34mPay attention to the repository:\033[0m"
    git remote -v
    sleep 1
    echo "\033[1;34mPushing...\033[0m"
    git push origin master
    if [ ${#2} -ge 2 ]
    then
      echo "\033[1;33mDeploying...\033[0m"
      hexo cl && hexo g && hexo d
    fi
  fi
fi
