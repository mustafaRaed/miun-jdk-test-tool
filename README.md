# Mesuring GraalVM Performance

This is a student project with the aim of measuring the performance of GraalVM on hundreds of Java opensource projects. This project at the moment only contains one project but will be populated with multiple other projects. 

## Folders and files
**gradle-repos**: A file containing a list of ssh urls of opensource Gradle projects.

**maven-repos**: A file containing a list of ssh urls of opensource maven projects.

**gradle-projects**: A folder that will contain cloned opensource projects.

**maven-projects**: A folder that will contain cloned opensource maven projects.

**jdks**: Should include the jdks that the projects will be tested with. 

**test-logs**: A folder that will contain a log file for each project, showing the logs that are outputted from maven/gradle. 

**test.sh**: Main script that will clone the maven and gradle projects written in the files, and run the tests of each project with the different jdks in the jdks folder (Will automatically set JAVA_HOME and PATH env vars). The script will output to stdout and to a file in the test-logs folder.(Currenty only implemented for Maven)

**remove_cloned_projects**: Run when you want to remove/delete the cloned projects in maven-projects and gradle-projects folders. 

## Run tests

To run the tests you will need to do the following:

1. Install maven and Gradle

2. Install the JDKS that will be tested and place them in the jdks/ folder. Here is the jdks I got in my filder 

```
graalvm-ce-java11-21.0.0.2  graalvm-ee-java11-21.0.0.2  java-11-openjdk-amd64  jdk-11.0.10
graalvm-ce-java8-21.0.0.2   graalvm-ee-java8-21.0.0.2   java-8-openjdk-amd64   jdk1.8.0_281

```
3. Run ./test.sh