#!bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root / sudo"
  exit
fi

echo -e "\n"
echo "Enter the following information:"

echo -e "\n"
echo "Enter your username:"
read -e -p "Enter Ubuntu username: ($SUDO_USER) " -i $SUDO_USER user_login

echo -e "\n"
echo "Let's set the GIT global credentials (optional):"
read -e -p "Enter Git Name (optional): " git_user_name
read -e -p "Enter Git Email (optional): " git_user_email

# TODO: check the telegram api, apparently things changed
# echo -e "\n"
# echo "Let's set the telegram chat to check on the ansible jobs (optional):"
# echo "This will make sure that the cron job will send a message to the telegram chat on success or failure"
# read -e -p "Enter Telegram Chat ID (optional): " telegram_chat_id
# read -e -p "Enter Telegram Token (optional): " telegram_token

echo -e "\n"
echo "Let's set the Healthchecks (https://healthchecks.io/) to additionally check on the ansible jobs (optional):"
echo "Get the UUID of the Healthchecks:"
read -e -p "Enter Healthcheck UUID (optional): " healthcheck_uuid

echo -e "\n\n\n"
echo "Confirm the information:"
echo "Username: $user_login"
echo "Git Name: $git_user_name"
echo "Git Email: $git_user_email"
# echo "Telegram Chat ID: $telegram_chat_id"
# echo "Telegram Token: $telegram_token"
echo "Healthcheck UUID: $healthcheck_uuid"

read -e -p "Confirm? [Y/n] " -i 'Y' response

while true; do
  case "$response" in
      [yY][eE][sS]|[yY])
        echo "Starting the installation..."
        break
        ;;
      *)
        echo "Aborting..."
        exit
        ;;
  esac
done


# add repositories
sudo apt-add-repository ppa:ansible/ansible

# updates the system
sudo apt update
sudo apt upgrade -y

# install ansible and git
sudo apt install ansible git -y

# ansible pull the playbook
ansible-pull -U 'https://github.com/Noriller/my-ansible.git' \
  -e "user_login=$user_login" \
  -e "cron_job_name='first install'" \
  -e "git_user_name=$git_user_name" \
  -e "git_user_email=$git_user_email" \
  -e "telegram_chat_id=$telegram_chat_id" \
  -e "telegram_token=$telegram_token" \
  -e "healthcheck_uuid=$healthcheck_uuid" \

# use --tags "tag1,tag2" to run only the tasks tagged with tag1 and tag2
# use this to limit stuff instead of hosts in the playbook (since we don't know the hosts yet using pull)
# use "tags: always" to set up to always run the play

# use --tags "always" to run only the tasks tagged with "always" (basically the basic stuff)
# run without --tags to run everything

# use --check --diff to make a dry run and see what would change