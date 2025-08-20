#/bin/bash
sudo apt update -y >/dev/null 2>&1
sudo apt install epel-release -y
sudo apt install wget git -y
sudo apt install openjdk-8-jdk -y
export JAVA_HOME_8_X64=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME_8_X64/bin:$PATH
sudo apt install maven -y