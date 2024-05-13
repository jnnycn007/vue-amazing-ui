# /bin/bash

# 确保脚本抛出遇到的错误
set -e

# 提交修改到github

commitDescInfo=$1

git add .

if [ -z ${commitDescInfo} ]; then
  git cm -m 'update'    `c vbnmnb j
  
else
  git cm -m ${commitDescInfo}
fi

git push
