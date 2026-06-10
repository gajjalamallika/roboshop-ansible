#!/bin/bash
folders=$(find roles -type d | awk -F"/" '{print $2}')


for i in ${folders[@]}
do 
  echo "folder $i"
  mkdir -p "roles/$i/files"
  mkdir -p "roles/$i/templates"
  mkdir -p "roles/$i/tasks"
  mkdir -p "roles/$i/vars"
done 

#move files to respective folders 

for i in ${folders[@]}
do 
    d=("yaml" "service" "repo")
    for j in ${d[@]}
    do 
        echo $j 
        yaml=$(find roles/$i -type f -name "*.$j")
        if [ -z "$yaml" ]; then 
            echo "null yaml varibale" 
        else 
            file_name=$(basename -- "$yaml")
            echo $file_name 
            if [ -e "roles/$i/$file_name" ]; then 
                if [ "$j" == "service" ]; then 
                    mv roles/$i/$file_name roles/$i/templates/
                fi 
                if [ "$j" == "yaml" ]; then 
                    mv roles/$i/$file_name roles/$i/tasks/main.yaml 
                fi 
                if [ "$j" == "repo" ]; then  
                    mv roles/$i/$file_name roles/$i/files/
                fi 
            fi 
        fi 
    done 
done 


#rename all yamls into main.yaml inside tasks folder 

