01. Clone script repo to directory with git projects:
    clone git https://github.com/lenrok258/git-pull-all-script.git

02. Make a symling pointing at script in projects directory:
    ln -s  git-pull-all-script/git-pull-all.sh ./git-pull-all.sh

03. Execute is manually or setup cron tab to execute in periodically:
    crontab -e
    */5 * * * * /projects/git-pull-all.sh 1> /dev/null

04. To execute script after pull was performed create file on-git-pull.sh in project directory, make it executable and commit it:
    echo "echo TEST" > on-git-pull.sh
    chmod u+x on-git-pull.sh
    git add on-git-pull.sh
    git commit -m "on-git-pull.sh"
    git push



    