#!/bin/bash

name="Linux"
ub="Ubuntu"
cent="Centos"
aws="Amazon"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Your OS LINUX"
        OS="Linux"
elif [[ "$OSTYPE" == "darwin" ]]; then
        echo "You OS OSX"
        OS="OSX"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "You OS WINDOWS"
        OS="Windows"
else "OS not found"
fi

if [[ "${OS}" == "Windows" ]]; then
        echo "Installing AWS CLI for WONDOWS"
        msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
elif [[ "${OS}" == "OSX" ]]; then
        echo "Installing AWS CLI for MAC"
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
        sudo installer -pkg AWSCLIV2.pkg -target /

elif [[ $OS == "Linux" ]];then
            linux_version=$(cat /etc/os-release | grep -m1 'NAME=' | awk '{print $1}' | cut -d'"' -f2)
            if [[ $linux_version = $ub ]];then
                echo "Installing AWS CLI for UBUNTU"
                apt -y update
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
            elif [[ $linux_version = $cent ]];then
                echo "Installing AWS CLI for CENTOS"
                yum -y update
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
            elif [[ $linux_version = $aws ]];then
                echo "Installing AWS CLI for AMAZON"
                yum -y update
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
            fi
fi
