::重新部署hexo至github
call hexo clean
call hexo g
call hexo d

::提交更新至github
call git add .
call git commit -m "update"
call git push origin :hexo