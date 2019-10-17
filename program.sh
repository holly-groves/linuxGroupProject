#!/bin/bash

# Group 18: Jordan Keiller, Holly Groves, Laura Huchison
# AC21009 - Computer Systems 2A: Architecture Fundamentals and Unix
# CMS using BASH

repoName=''
fileName=''

#creates a new repository
#asks the user to input the name of the repository to create
#if the repository already exists then the user will be moved into that repository
createRepository(){
	echo "Please enter the name of the repository you would like to create."
	echo "Enter repository name:"
	read repoName #gets user input for the name of the repository 
	if [ -d "${repoName}" ] #if the repository does exist already
	then
		#moves the user to that repository and displays messege that it already exists
		echo ""
		echo "Oops! It looks like this repository already exists. Moving you there now.."
		cd "${repoName}"
		echo ""
		echo "Current Directory: "
	else #if the repository doesn't already exist
		mkdir "${repoName}" #make a new folder with the repository name
		cd "${repoName}" #move into the new repository
		mkdir .tmp #make a hidden folder called 'tmp'
		echo ""
		echo "Success! The repository ${repoName} has been created. Moving you there now..."
		echo ""
		echo "Current Directory: "
	fi
	pwd
	repoMenu ##calls the function: repoMenu()
}

#accesses a repository
#asks the user to input the repository they would like to go to
#if the repository doesn't exists it will give the user the option to create a repository with that name
accessRepository(){
	echo "Please enter the name of the repository you would like to access."
	echo "Enter repository name:"
	read repoName #gets the user input for the name of the repository
	if [ ! -d "${repoName}" ] #if the repository doesn't exist 
	then
		#give the user the option to create a new repository with this name
		echo ""
		echo "Oops! This repository doesn't exist. Please select an option below:"

		#menu to display the options the user has
		accessRepositoryOptions=("Create the repository ${repoName}" "Go back to the main menu")
		select opt in "${accessRepositoryOptions[@]}"
		do
			case $opt in
				"Create the repository ${repoName}") #creates the new repository for the user
					mkdir "${repoName}" #make new directory with the repository name from the user
					echo ""
					echo "Success! The repository ${repoName} has been created. Moving you there now..."
					#moves the user into the new repository
					cd "${repoName}"
					echo ""
					echo "Current Directory:"
					pwd
					repoMenu #goes to the repoMenu function
					break
					;;
				"Go back to the main menu") #takes the user back to the main menu (mainMenu() function)
					echo "Returning you to the main menu..."
					break
					;;
				*) #invalid option
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #if the repository does exist
		echo ""
		echo "Moving you to the ${repoName} repository.."
		cd "${repoName}"
		repoMenu #runs the menu for the repository (repoMenu()function)
	fi
	echo ""
	#displays what repository the user will now be in (where the user is)
	echo "Current Directory: "
	pwd
}

#removes a repository
#asks the user which repository they would like to remove
#will then remove the repository and all it's contents
removeRepository(){
	echo "Please enter the name of the repository you would like to remove."
	echo "Enter repository name:"
	read removeRepositoryName #gets the user input for the name of the repository
	if [ -d "${removeRepositoryName}" ] #if the repository exists
	then
		echo ""
		echo "Are you sure you would like to remove this repository and all of its contents?"

		#menu to enusre the user wants to delete the repository and it's contents
		accessDirectoryOptions=("Remove the repository ${removeRepositoryName}" "Cancel and go back")
		select opt in "${accessDirectoryOptions[@]}"
		do
			case $opt in
				"Remove the repository ${removeRepositoryName}") #removes the repository
					rm -r "${removeRepositoryName}" #recursively removes the repository
					echo ""
					echo "Success! The repository ${removeRepositoryName} has been removed."
					break
					;;
				"Cancel and go back") #takes the user back to the repository menu
					echo ""
					echo "Repository deletion has been cancelled."
					echo "Returning you to the repository menu..."
					break
					;;
				*) #invalid option
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #the repository does not exist
		echo ""
		echo "The repository ${removeRepositoryName} doesn't exist."
		#the user will be taken back to the repository menu (repoMenu() function)
	fi
}

#archives a repoisotry
#gives a the user a choice of using .tar or .zip to compress the repository
archiveRepository(){
	echo "Please enter the name of the repository you would like to archive"
	echo "Enter repository name:"
	read repoName #gets the user input for the name of the repository
	if [ -d "${repoName}" ] #if the repository exists
	then
		echo ""
		echo "Choose a compression method below:"

		#menu to give the diffferent compression options
		archiveDirectoryOptions=("${repoName}.tar" "${repoName}.zip" "Cancel and go back")
		select opt in "${archiveDirectoryOptions[@]}"
		do
			case $opt in
				"${repoName}.tar") #compresses using .tar
					echo ""
					tar cf "$(date +"%d-%m-%y-%h-%s")${repoName}.tar" "${repoName}/" #compresses the repository using .tar
					#the file name will give the date and time it was compressed along with the repository name
					echo "Success! The repository has been archived. File name: $(date +"%d-%m-%y-%h-%s")${repoName}.tar"
					break
					;;
				"${repoName}.zip") #compresses using .zip
					echo ""
					zip  -q "$(date +"%d-%m-%y-%h-%s")${repoName}.zip" "${repoName}/" #compresses the repository using .zip
					#the file name will give the date and time it was compressed along with the repository 
					echo "Success! The repository has been archived. File name: $(date +"%d-%m-%y-%h-%s")${repoName}.zip"
					break
					;;
				"Cancel and go back") #takes user back to the main menu (mainMenu() funciton)
					echo ""
					echo "Archiving a repository has been cancelled."
					echo "Returning you to the main menu..."
					break
					;;
				*) #invalid input
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #if the repository doesn't exist
		echo ""
		echo "The repository ${repoName} doesn't exist."
		#takes user back to the main menu (mainMenu() function)
	fi

}

#move the user from the current directory to it's parent directory
moveParentDirectory(){
	if [[ $(pwd) = $baseDir/$repoName ]] #if the user is currently in the repository folder itself
 	then
 		#the user cannot go back any further within this repository
 		echo ""
		echo "Oops! It looks like you can't go back any further. Return to main menu for repository options."
	else #if there is a parent directory to go back to 
		cd ..
	fi
	echo ""
	echo "Current Directory: "
	pwd
}

#creates a new directory
createDirectory(){
	echo "Enter the name of the new directory:"
	read newDirectoryName #gets the user input for the name of the directory
					
	if [ -d "${newDirectoryName}" ] #if the directory already exists
	then #take the user to that directory
		echo ""
		echo "Oops! It looks like this directory already exists. Moving you there now..."
		cd "${newDirectoryName}" 		
	else #the directory doesn't already exist
		mkdir "${newDirectoryName}"
		echo ""
		echo "Success! The directory ${newDirectoryName} has been created. Moving you there now..."
		cd "${newDirectoryName}"
	fi
		echo ""
		echo "Current directory:"
		pwd	
}

#accesses a directory
accessDirectory(){
	echo "Please enter the name of the directory you would like to access."
	echo "Enter directory name:"
	read accessDirectoryName #gets the user input for the name of the directory

	if [ ! -d $accessDirectoryName ] #if the directory doesn't exist
	then 
		echo ""
		echo "Oops! This directory doesn't exist. Please select an option below:"

		#menu to give the user the option to create the directory
		accessDirectoryOptions=("Create the directory ${accessDirectoryName}" "Go back to the repository menu")
		select opt in "${accessDirectoryOptions[@]}"
		do
			case $opt in
				"Create the directory ${accessDirectoryName}") #create the directory and move into it
					mkdir "${accessDirectoryName}"
					echo ""
					echo "Success! The directory ${accessDirectoryName} has been created. Moving you there now..."
					cd "${accessDirectoryName}"
					break
					;;

				"Go back to the repository menu") #go back to the main menu (mainMenu() function)
					echo "Returning you to the repository menu..."
					break
					;;
				*) #invalid input
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #if the directory already exists
		echo ""
		echo "Moving you to the ${accessDirectoryName} directory.."
		cd "${accessDirectoryName}"
		
	fi
	echo ""
	echo "Current Directory: "
	pwd
}


#remove a directory
removeDirectory(){
	echo "Please enter the name of the directory you would like to remove."
	echo "Enter directory name:"
	read removeDirectoryName #gets the user input for the name of the directory
	if [ -d "${removeDirectoryName}" ] #if the directory does exist
	then
		echo ""
		echo "Are you sure you would like to remove this directory and all of its contents?"

		#menu to ensure the user wants to delete the directory and it's contents
		accessDirectoryOptions=("Remove the directory ${removeDirectoryName}" "Cancel and go back")
		select opt in "${accessDirectoryOptions[@]}"
		do
			case $opt in
				"Remove the directory ${removeDirectoryName}") #remove the directory
					rm -r "${removeDirectoryName}"
					echo ""
					echo "Success! The directory ${removeDirectoryName} has been removed."
					break
					;;
				"Cancel and go back") #go back to the repositroy menu (repoMenu() function)
					echo ""
					echo "Directory deletion has been cancelled."
					echo "Returning you to the repository menu..."
					break
					;;
				*) #invalid input
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #if the directory doesn't exist
		echo ""
		echo "The directory ${removeDirectoryName} doesn't exist."
	fi
}

#create a new file by asking the user for file name
createFile(){
	echo "Enter the name of the file you would like to create (e.g. test.txt)"
	read fileName
	
	if [ -e "${fileName}" ] #if the file can be opened/exists
	then

		# Display an error message since the user is trying to create a file that already exists
		echo ""
		echo "Oops! It looks like this file already exists. Please select a menu option below.."
		echo ""
		createFileOptions=("Remove the file ${fileName} and create a new ${fileName}" "Edit/append to the current version of file ${fileName}" "Go back to the repository menu")
		select opt in "${createFileOptions[@]}"
		do
			case $opt in
				"Remove the file ${fileName} and create a new ${fileName}")
					rm "${fileName}"
					touch "${fileName}"
					nano "${fileName}"
					echo ""
					echo "Success! The old version of the file has been successfully removed and the new version implemented."
					break
					;;
				"Edit/append to the current version of file ${fileName}")
					checkOutFile
					break
					;;
				"Go back to the repository menu")
					echo ""	 
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	else

		#if the file can't be opened/doesn't exist, then create it
		touch "${fileName}"
		echo ""
		echo "Please select one of the text editors below:"
		echo ""

		# offer the user a choice of text editors to use when creating their file
		subCreateFileOptions=("nano ${fileName}" "vim ${fileName}" "subl ${fileName} (Sublime Text)" "atom ${fileName} (Atom)" "Cancel and go back")
		select opt in "${subCreateFileOptions[@]}"
		do
			case $opt in
				"nano ${fileName}")
					nano "${fileName}"
					echo ""
					echo "Success! The file ${fileName} was sucessfully created and your edits were saved!"
					break
					;;
				"vim ${fileName}")
					vim "${fileName}"
					echo ""
					echo "Success! The file ${fileName} was sucessfully created and your edits were saved!"
					break
					;;
				"subl ${fileName} (Sublime Text)")
					subl "${fileName}"
					echo ""
					echo "Success! The file ${fileName} was sucessfully created. Remember to save your edits in the external editor for the changes to take effect!"
					break
					;;
				"atom ${fileName} (Atom)")
					atom "${fileName}"
					echo ""
					echo "Success! The file ${fileName} was sucessfully created. Remember to save your edits in the external editor for the changes to take effect!"
					break
					;;
				"Cancel and go back")
					echo "" 
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	fi
}

# allows the user to access/edit a file
accessFile(){
	echo ""
	echo "Enter the name of the file you would like to access/edit (e.g. test.txt)"
	read fileName
	if [ -e "${fileName}" ] # if the file already exists, let the user edit it
	then
		checkOutFile 
	else #if the file doesn't exist, show an error message and present with prompts
		echo ""
		echo "Oops! The file ${fileName} doesn't exist. Please select an option below."
		echo ""
		accessFileOptions=("Create the file ${fileName}" "Go back to the repository menu")
		select opt in "${accessFileOptions[@]}"
		do
			case $opt in

				# offer the choice to create the file
				"Create the file ${fileName}")
					touch "${fileName}"
					nano "${fileName}"
					echo ""
					echo "Success! The file ${fileName} has been created."
					break
					;;

				# or go back to the menu and cancel editing a file
				"Go back to the repository menu")
					echo ""
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	fi
}

checkOutFile(){ 
	echo ""
	echo "Please select one of the text editors below:"
	checkOutFileOptions=("nano ${fileName}" "vim ${fileName}" "subl ${fileName} (Sublime Text)" "atom ${fileName} (Atom)" "Cancel and go back")
	select opt in "${checkOutFileOptions[@]}"
	do
		case $opt in
			"nano ${fileName}")
				cp "${fileName}" "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				nano "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				checkInFile
				break
				;;
			"vim ${fileName}")
				cp "${fileName}" "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				vim "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				checkInFile 
				break
				;;
			"subl ${fileName} (Sublime Text)")
				cp "${fileName}" "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				subl "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				checkInFile
				break
				;;
			"atom ${fileName} (Atom)")
				cp "${fileName}" "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				atom "${fileName}-checkedOut-$(date +"%d-%m-%y")"
				checkInFile
				break
				;;
			"Cancel and go back")
				echo "" 
				echo "Returning you to the repository menu..."
				break
				;;
			*)
				echo "Please enter a valid option!"
				;;
		esac
	done
}

checkInFile() { 
	if [ -e  "${fileName}-checkedOut-$(date +"%d-%m-%y")" ]
	then
		echo ""
		echo "Success! File created with name: ${fileName}-checkedOut-$(date +"%d-%m-%y")"
		echo ""
		echo "Would you like to check your file back into the repository and update the master file: ${fileName}?"
		echo ""
		echo "Note: Remember to save your file first if you're using an external editor!!"
		checkInFileOptions=("Update and overwrite ${fileName}" "Cancel and go back")
		select opt in "${checkInFileOptions[@]}"
		do
			case $opt in
				"Update and overwrite ${fileName}")
					cp "${fileName}-checkedOut-$(date +"%d-%m-%y")" "${fileName}"
					echo ""
					echo "Success! ${fileName} has successfully been overwritten."
					break
					;;
				"Cancel and go back")
					echo "" 
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	else
		echo "Oops! The file wasn't edited."
	fi
	
}

#remove a file
removeFile(){
	echo "Enter the name of the file you would like to access/edit (e.g. test.txt)"
	read fileToRemove #gets the user input for the name of the file

	
	if [ -e "${fileToRemove}" ] #if the file exists
	then
		echo ""
		echo "Are you sure you would like to remove this file?"
		removeFileOptions=("Remove the file: ${fileToRemove}" "Cancel and go back")
		select opt in "${removeFileOptions[@]}"
		do
			case $opt in
				"Remove the file: ${fileToRemove}")
					rm "${fileToRemove}"
					echo ""
					echo "Success! The file ${fileToRemove} has been removed."
					break
					;;
				"Cancel and go back")
					echo "" 
					echo "File removal has been cancelled.."
					echo "Returning you to the repository menu..."
					break
					;;
				*)
					echo "Please enter a valid option!"
					;;
			esac
		done
	else #the file doesn't exist
		echo ""
		echo "The file ${fileToRemove} doesn't exist"
	fi
}

#lists the contents of the repository
listRepoContents(){
	echo ""
	echo "Listing the contents for: "
	pwd
	echo ""

	#prints a list of directorys in the current directory the user is in
	echo "Directories: "
	if [ "$(ls -d  */)" ] #if there are directories
	then
		ls -d  */ #displays the directories withn the repository
	else #if there are no directories
		echo "There are no directories to display. Try creating one."
	fi	
	echo ""

	#shows files only
	#grep will return lines that don't contain a slash
	echo "Files:"
	if [ "$(ls -p | grep -v /)" ] #if there are files to display
	then
		ls -p | grep -v / #display the files
	else #if there are no files wihtin the repository
		echo "There are no files to display. Try creating one."
	fi
}

#runs the repository menu which gives options the user can use within a repository
repoMenu(){
	while true
	do
	    echo "-------------------------------------------------------------------------"
		echo "                         Repository Menu: $repoName                      "
		echo " Select one of the menu options by entering the relevant number (e.g. 1) "	
		echo "-------------------------------------------------------------------------"
		options=("Move to the parent directory" "Create a new directory" "Access a directory" "Remove a directory" 

		"Create a new file"  "Access a file"  "Remove a file" "List the repository contents"	"Go back to the main menu")
		select opt in "${options[@]}"
		do
			case $opt in
				"Move to the parent directory")
					moveParentDirectory #calls the function: moveParentDirectory()
					break 
					;;
				"Create a new directory")
					createDirectory #calls the function: createDirectory()
					break
					;;
				"Access a directory")
					accessDirectory #calls the function: accessDirectory()
					break
					;;
				"Remove a directory")
					removeDirectory #calls the function: removeDirectory()
					break
					;;
				"Create a new file")
					createFile #calls the function: createFile()
					break
					;;
				"Access a file")
					accessFile #calls the function: accessFile()
					break
					;;
				"Remove a file")
					removeFile #calls the function: removeFile()
					break
					;;
				"List the repository contents")
					listRepoContents #calls the function: listRepoContents()
					break
					;;
				"Go back to the main menu")
					cd ..
					echo "Returning you to the main menu..."
					echo ""
					echo "Current Directory:"
					pwd
					mainMenu #calls the function: mainMenu()
					;;
				*) #invalid input
					echo "Please enter a valid number!"
					;;
			esac
		done
	done
}

#runs the main menu for the script
mainMenu () {
	while true
	do
		echo "-------------------------------------------------------------------------"
		echo "                             Main Menu                                   "
		echo " Select one of the menu options by entering the relevant number (e.g. 1) "	
		echo "-------------------------------------------------------------------------"
		options=("Create a repository" "Access a repository" "Remove a repository" "Archive a repository" "Exit menu")
		select opt in "${options[@]}"
		do
			case $opt in
				"Create a repository")
					createRepository #calls the function: createRepository()
					break
					;;
				"Access a repository")
					accessRepository #calls the function: accessRepository()
					break
					;;
				"Remove a repository")
					removeRepository #calls the function: removeRepository()
					break
					;;
				"Archive a repository")
					archiveRepository #calls the function: archiveRepository()
					break
					;;
				"Exit menu") #exit the menu
					echo ""
					echo "Exiting the menu... Goodbye!"
					exit #exits the script
					;;
				*)
					echo "Please enter a valid number!"
					;;
			esac
		done
	done
}

baseDir=$(pwd) #sets baseDir to the current directory the user is in
mainMenu #runs the main menu function