#! /bin/bash 
date=$(date "+%d_%m_%y_%H%M") 
script log${date}_$USER.txt -c 'bash program.sh'