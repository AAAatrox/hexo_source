# cd ~/blog/source
version=$(uname)
echo "${version}"
for filename in ~/blog/source/_posts/*.md
do
  old=$(sed -n "3p" ${filename}) # 提取第3行
  new="${old#updated}" # 除去updated项
  updated="updated: "$(date "+%s") # 1907年至今的秒数
  if [ "${new}" != "${old}" ] # 有updated项
  then
    changed=$(git diff ${filename})
    changed_num=${#changed}
    if [ ${changed_num} -ge 10 ] # 发生了改变
    then
      echo ${filename} " changed " ${changed_num}
      if [ "${version}" = "Linux" ]
      then
        sed -i -e '3c\'${updated} ${filename}
      elif [ "${version}" = "Darwin" ]
      then
        sed -i '' -e '3c \
          '${updated} ${filename}
      else
        echo "unknown system!"
      fi
    fi
  else # 没有updated项
    echo "${filename} doesn't have updated OPT"
    if [ "${version}" = "Linux" ]
    then
      sed -i -e '3i\'${updated} ${filename}
    elif [ "${version}" = "Darwin" ]
    then
      sed -i '' -e '3i \
        '${updated} ${filename}
    else
      echo "unknown system!"
    fi
  fi
done
# cd -
