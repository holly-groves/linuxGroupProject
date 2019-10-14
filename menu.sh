#!/bin/bash

repoName=''

while :
do
echo "-------------------------------------------------------------------------"
echo "                             Main Menu                                   "
echo " Select one of the menu options by entering the relevant number (e.g. 1) "
echo "-------------------------------------------------------------------------"

options=("Create/access a repository" "List the contents of the current directory" "Show directory movement options" 
	"Log a file out of the repository" "Exit menu")

select action in "${options[@]}"
do
case $action in
	"Create/access a repository")
		echo ""
		echo "Please enter the name of the repository you would like to access. If it doesn't exist, you will be given the option to create one."
		echo ""
		echo "Enter repository name:"
		read repoName
	#	path=pwd #doesn't work, assigns pwd instead of the running command
		if [ !$repoName ] #if the repo doesn't exist
		then
			echo ""
			echo "Oops! This repository doesn't exist. Select one of the menu options below."
			select action in "Create the repository ${repoName}" "Go back to main menu"
			do
			case $action in
				"Create the repository ${repoName}")
					mkdir $repoName
					cd $repoName
					mkdir .tmp
					echo ""
					echo "Success! The repository ${repoName} has been created. Moving you there now..."
					break
					;;
				"Go back to main menu")
					echo "Returning you to the main menu...."
					break
					;;
				*) 
					echo "Oops! Please enter a valid menu option.. "
					;;
			esac
			done
		else # if the repo does already exist
			cd $repoName	# move into it
		fi
		echo ""
		echo "Current directory: "
		pwd
		;;
	"List the contents of the current directory")
		echo "Listing the contents for directory: "
		pwd
		echo ""

		# Prints a list of directors in the current directory the user is in
		echo "Directories: "
		
		# If there are no directories at all, display an error message
		if [ ! -d */ ]
		then
			echo "Oops! Looks like there aren't any directories in here!"
		else
			ls -d */
		fi	
		
		echo ""

		# Shows files only. Grep will return lines that don't contain a slash
		echo "Files:"
		ls -p | grep -v /
		;;

	#broken but works
	"Show directory movement options")
		echo "Directory and file movement options"

		select action in moveUpDirectory goBack
		do
		case $action in 
			moveUpDirectory)

				if [ $repoMainDirectory ]
 				then
				
					echo "Can't go back further"

				else
					cd ..
				fi

				break
				;;				
			goBack)
				break
				;;
			*) 
				echo "invalid input"
				;;
			esac
		done
		pwd
		;;
	"Log a file out of the repository")
		echo "Log out a file"
		echo "Enter the file you want to log out"
		read fileName
		cp $fileName /.tmp
		;;	quit)
		break
		;;
	"Exit menu")
		exit
		;;
	*)
		echo "Invalid input"
		;;
esac
done
done

