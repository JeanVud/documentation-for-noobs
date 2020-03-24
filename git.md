# reference
https://www.youtube.com/watch?v=SWYqp7iY_Tc&t=605s

# create file
touch index.html

touch app.js

# start a folder as git repository
git init

# add name and email address to git
git config --global user.name 'Jean Vu'

git config --global user.email 'jean.say.hi@gmail.com'

# add file to local repository / staging area
git add index.html

	#add specific file
	
git add *.html

	#add any html file to the staging area	
	
git add .

	#add everything	

# check what's in the staging area
git status

	#changes to be commmitted: staging area, files that have been added to the staging area
	#untracked files: files that haven't been uploaded to staging area
	#changes not staged for commit: we added some kind of change to the file while it was in staging area. git tells you to re-add that file
		-> git add .

# remove file from staging area
git rm --cached index.html

# commit files to the repository
git commit
	-> vim editor: refer to ref1
git commit -m '<message>'
	# for instance: git commit -m 'changed app.html'

# clear git command
clear

# create .gitignore file ignore files
touch .gitignore
	#inside .gitignore file, write file or directory you want to ignore
	#for instance app.html xuống dòng  /directory1 xuống dòng /directory2

# create new branch
git branch <branch_name>
	#ie: git branch login

# switch to a particular branch
git checkout login	#switch to baby branch
git checkout master	#switch to master branch

# merge baby branch with master branch
git merge <baby_branch>
	#ie: git merge login

# list the remote repositories that we have
git remote

# push an existing repository from the command line
git remote add origin <git_link.git>

# upload local repository to remote repository
git push -u origin master

# download a repository
git clone <link.git>

# get latest ver of a repo, see everything up-to-date
git pull


#STEPS TO CREATE A FILE LOCALLY AND UPLOAD TO REMOTE REPOSITORY
touch README.md
git add .
git commit -m '<commit message>'
git push



