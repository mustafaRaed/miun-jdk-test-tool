export repo_root=$(pwd);

cd $repo_root/maven-projects;
echo \#\#Cloning maven projects;
while read l; 
  do   
    git clone "$l"; 
  done <../maven-repos.txt;
echo \#\#Done cloning maven projects;echo;echo;

cd $repo_root/gradle-projects;
echo \#\#Cloning gradle projects;
while read l; 
  do   
    git clone "$l"; 
  done <../gradle-repos.txt;
echo \#\#Done cloning gradle projects;echo;echo;
