if [ "$1"x = x ]
then
	echo "\033[1;31mNeed message\033[0m"
else
	zsh source/_posts/my_sort.sh
	echo "\033[1;32mAdding...\033[0m"
	git add my_update.sh
	git add _config.yml
	git add package.json
	git add source
	git commit -m $1
	echo "\033[1;33mPushing...\033[0m"
	if [ "$2"x != x ]
	then
		hexo cl && hexo g && hexo d
		git push origin master
	else
		echo "\033[1;34mAbort\033[0m"
	fi
fi
