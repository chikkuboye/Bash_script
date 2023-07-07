#!/bin/bash

file="userpass"

generate_pass(){
	echo "What is the user name"
	read username
	echo "Generate the password"
	read password
	length=${#password}
	if [[ $length -gt 7 && ($password =~ [A-Z] || $password =~ [a-z] || $password =~ [0-9] || $password =~ [[:punct:]]) ]]
	then
		echo "password is generated"
		if grep -q "^$username:" "$file"; then
    
    			sed -i "/^$username:/d" "$file"
    			echo "$username:$password" >> $file
		
			# user_pass[$1]=$password
			encrypted_password=$(echo "$password" | openssl aes-256-cbc -a)

			# Store the encrypted password in a file with restricted permissions
			echo "$encrypted_password" >> password.txt
			chmod 600 password.txt
		else
			echo "$username:$password" >> $file
		
			# user_pass[$1]=$password
			encrypted_password=$(echo "$password" | openssl aes-256-cbc -a)

			# Store the encrypted password in a file with restricted permissions
			echo "$encrypted_password" >> password.txt
			chmod 600 password.txt
		
    		fi
		#echo "$username:$password" >> $file
		
		# user_pass[$1]=$password
		#encrypted_password=$(echo "$password" | openssl aes-256-cbc -a)

		# Store the encrypted password in a file with restricted permissions
		#echo "$encrypted_password" >> password.txt
		#chmod 600 password.txt
	else
		echo "Your password does not contain the criteria"
	fi	
}



#declare -a action_to_be_required=("store" "retrive" "update" "delete")

echo "welcome to password manager . Select What you have to do on your password
       
       1. Store
       2. Retrive
       3. Update
       4. Delete"
read action

if [ "$action" == "1" ]
then
	# echo "Provide the user name"
	# read user
	generate_pass 
	
elif [ "$action" == "2" ]
then
    echo "Provide the username:"
    read user
    password=$(grep "^$user:" "$file" | awk -F':' '{print $2}')
    echo "Password for the user is $password"
	
elif [ "$action" == "3" ]
then
	#echo "provide the user name"
	#read user
	generate_pass 
	# echo "Update the password"
	# read updated_pass
	# user_pass[$user]=$updated_pass
elif [ "$action" == "4" ]
then
	echo "Provide the user name for deleting"
	read delete_user
	sed -i "/^$delete_user:/d" "$file"
	# unset user_pass[$delete_user]

fi





