#!/bin/bash

source $HOME/.profile
cd $(dirname $0)

SCRIPT_DIR=$(pwd)
LOG_FILE_FULL_PATH=${SCRIPT_DIR}/git-pull-all.log


# Clean up/create log file
echo "" > ${LOG_FILE_FULL_PATH}

function log {
	textToEcho=$1;
	echo $textToEcho | tee -a ${LOG_FILE_FULL_PATH}
}

# Iterate over all folders in current location
for i in `ls -d */`; do
	log "Start: $i";
	pushd $i;

    # If there are any changes in remote repo - make a pull
    anyChanges=$(git fetch --dry-run 2>&1)
    if [ ! -z "${anyChanges}" ]; then
        log "New changes found. About to pull $i";
        git pull 2>&1 | tee -a ${LOG_FILE_FULL_PATH}

        # If on-git-pull.sh is present - execute it
        if [[ -x "on-git-pull.sh" ]]; then
            log "Script 'on-git-pull.sh' found in $i. About to execute it.";
            ./on-git-pull.sh | tee -a ${LOG_FILE_FULL_PATH} &
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
