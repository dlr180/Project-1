#!/bin/bash
mkdir research-week6
{
echo "Here are the executable files"

sudo find /home -type f -perm 777 >> ~/research-week6/sys_info.txt
echo ""
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> ~/research_week6/sys_info.txt
echo""
echo "A Quick System Audit Script"
date
echo ""
echo "Machine Type Info:"
echo $MACHTYPE
echo -e "Uname info: $(uname -a) \n"
echo -e "IP Info: $(ip addr | grep inet | tail -2 | head -1) \n"
echo""
echo "Hostname: $(hostname -s) "
echo "DNS Servers: "
cat /etc/resolv.conf >> $output
echo""
echo "Memory Info:"
free >> $output
echo -e "\nCPU Info:"
lscpu | grep CPU >> $output
echo""
echo -e "\nDisk Usage:"
df -H | head -2 >> $output
echo""
echo -e "\nWho is logged in: \n $(who) \n"
} >> ~/research-week6/sys_info.txt

# Defining Variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | addr | inet |tail -2 | head -1)
suids=$(sudo find / -type f -perm 777 2 > /dev/null)


# Check for Research Drectory. Create if needed.
if [ ! -d $HOME/research ]
then
mkdir $HOME/research
fi

# check the output file. Clear it if needed.
if [ ! -f $output ]
then 
 > $output
fi


# Paths of /etc/shadow and /etc/passwd in to a list

users_and_passwds_list=(etc/shadow /etc/passwd)

for $users_and_passwds_list stat -f
	echo file permissions

# Bonus "For Loop" that checks for sudo abillities of each user with a Home folder on system


for users /home
