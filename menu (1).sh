#!/bin/bash
echo "Menu"

select action in access list fileLogOut quit
do
case $action in
	access)
		echo "Access a repository"
		echo "Enter repository name"
		read repoName
	#	path=pwd #doesn't work, assigns pwd instead of the running command
		if [ !pwd/$repoName ] #if the repo doesn't exist
		then
			echo "This repository doesn't exist"
			select action in createNewRepository goBack
			do
			case $action in
				createNewRepository)
					mkdir $repoName
					cd $repoName
					mkdir .tmp
					break
					;;
				goBack)
					break
					;;
				*) 
					echo "invalid input"
			esac
			done
		fi
		pwd
		;;
	list)
		echo "List all files"
		pwd
		ls
		;;
	fileLogOut)
		echo "Log out a file"
		echo "Enter the file you want to log out"
		read fileName
		sudo cp $fileName /.tmp
		;;	quit)
		break
		;;
	*)
		echo "Invalid input"
		;;
esac
done
