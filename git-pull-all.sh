#!/bin/bash

cd $(dirname $0)

# ############################################################
# Functions:

function myEcho {
	textToEcho=$1;
	echo $textToEcho | tee -a git-pull-all.log
}


# ############################################################
# Main:

echo "" > git-pull-all.log;

for i in `ls -d */`; do 
	myEcho "Start: $i";
	pushd $i;
	git pull  2>&1 | tee -a ../git-pull-all.log;
	popd;
	myEcho "End: $i";
	myEcho "----------------------------------------------------";
	myEcho;
done

echo;
echo "############################################################"
echo;
echo "Errors:";
cat git-pull-all.log | grep "error:";
