#!/bin/bash

cd $(dirname $0)

# Log file
echo "" > git-pull-all.log;

function log {
	textToEcho=$1;
	echo $textToEcho | tee -a git-pull-all.log
}

# Iterate over all folders in current location 
for i in `ls -d */`; do 
	log "Start: $i";
	pushd $i;

    # If there are any changes in remote repo - make a pull
    anyChanges=$(git fetch --dry-run 2>&1)
    if [ ! -z "${anyChanges}" ]; then
        log "New changes found. About to pull $i";
        git pull 2>&1 | tee -a ../git-pull-all.log;

        # If on-git-pull.sh is present - execute it
        if [[ -x "on-git-pull.sh" ]]; then
            log "Script 'on-git-pull.sh' found in $i. About to execute it.";
            source ./on-git-pull.sh
        fi;
    fi;    
	
    popd;
	log "End: $i";
	log "----------------------------------------------------";
	log;
done

echo;
echo "############################################################"
echo;
echo "Errors:";
cat git-pull-all.log | grep "error:";
