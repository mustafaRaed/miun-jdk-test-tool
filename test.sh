#!/bin/bash

# Set environment variables
export original_path=$PATH;
export repo_root=$(pwd);

clear

# Check availablity of required tools
mvn -v > /dev/null;
if [ $? -ne 0 ]
then
  echo "Apache Maven build tool not installed, please install it before proceeding!";
  exit 0;
fi

gradle -v > /dev/null;
if [ $? -ne 0 ]
then
  echo "Gradle build tool not installed, please install it before proceeding!";
  exit 0;
fi

declare -a list_of_jdks=(graalvm-ee-java11-21.0.0.2 graalvm-ce-java11-21.0.0.2 jdk-11.0.10 java-11-openjdk-amd64 graalvm-ee-java8-21.0.0.2 graalvm-ce-java8-21.0.0.2 jdk1.8.0_281 java-8-openjdk-amd64);

#declare -a list_of_jdks=(graalvm-ee-java11-21.0.0.2 graalvm-ce-java11-21.0.0.2 jdk-11.0.10 openjdk-11.0.10_9 graalvm-ee-java8-21.0.0.2 graalvm-ce-java8-21.0.0.2 jdk1.8.0_281 openjdk-8u282-b08);

#Run only a specific project "test.sh <m/g> <project-name>"
if [[ -n $2 ]]
then
  specific_project=$2;
  echo "Run Only Project: $specific_project";
fi

#Only run gradle if "test.sh g", both if "test.sh"
if [[ $1 == "g" || -z $1 ]]
then
  echo "=====[ Run Gradle ]=====";
  for gradle_project in gradle-projects/*;
  do
    for jdk in ${list_of_jdks[@]};
    do
      cd $repo_root;
      export JAVA_HOME=$repo_root/jdks/$jdk;
      export PATH=$repo_root/jdks/$jdk/bin:$original_path;

      echo;echo;
      echo \#\#Running $jdk;
      java -version;
      echo;

      echo;echo;
      gradle -v;
      echo;

      [[ $gradle_project =~ /(.*) ]];
      if [[ -z $2 || "$gradle_project" == "gradle-projects/$specific_project" ]]
      then
        cd $gradle_project/;
        for i in {1..5}
        do
          echo \#\#Running ${BASH_REMATCH[1]} with $jdk Round $i | tee -a $repo_root/test-logs/${BASH_REMATCH[1]}-log.txt;
          echo;
          ./gradlew tasks;
          ./gradlew clean;
          time ./gradlew test 2>&1 | tee -a ../../test-logs/${BASH_REMATCH[1]}-log.txt;
          echo;echo;
        done
        cd $repo_root;
      fi
    done
  done
else
  echo "=====[ Skipping Gradle ]=====";
fi

#Only run maven if "test.sh m", both if "test.sh"
if [[ $1 == "m" || -z $1 ]]
  then
  echo "=====[ Run Maven ]=====";
  for maven_project in maven-projects/*;
  do
    for jdk in ${list_of_jdks[@]};
    do
      cd $repo_root;
      export JAVA_HOME=$repo_root/jdks/$jdk;
      export PATH=$repo_root/jdks/$jdk/bin:$original_path;

      echo;echo;
      echo \#\#Running $jdk;
      java -version;
      echo;

      echo;echo;
      mvn -v;
      echo;

      [[ $maven_project =~ /(.*) ]];
      if [[ -z $2 || "$maven_project" == "maven-projects/$specific_project" ]]
      then
        cd $maven_project/;
        for i in {1..5}
        do
          echo \#\#Running ${BASH_REMATCH[1]} with $jdk Round $i | tee -a $repo_root/test-logs/${BASH_REMATCH[1]}-log.txt;
          echo;
          mvn clean;
          time mvn test 2>&1 | tee -a ../../test-logs/${BASH_REMATCH[1]}-log.txt;
          echo;echo;
        done
        cd $repo_root;
      fi
    done
  done
else
  echo "=====[ Skipping Maven ]=====";
fi
