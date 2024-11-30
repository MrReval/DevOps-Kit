#!/bin/bash

GITHUB_API="https://api.github.com/user/repos"
GITHUB_API_HOOKS="https://api.github.com/repos/"

echo "Please enter your GitHub username: "
read github_user
echo "Please enter your GitHub token (Personal Access Token): "
read -s github_token

get_repositories() {
  echo "Fetching repositories for $github_user..."
  curl -s -H "Authorization: token $github_token" $GITHUB_API | jq -r '.[].full_name'
}

choose_repository() {
  repositories=$(get_repositories)
  echo "Available Repositories:"
  select repo in $repositories; do
    if [[ -n "$repo" ]]; then
      echo "You selected: $repo"
      REPO_NAME=$repo
      break
    else
      echo "Invalid selection, try again."
    fi
  done
}

deploy_git_repo() {
  echo "Please enter the container name: "
  read container_name
  echo "Please enter the project directory inside the container (e.g., /app): "
  read project_directory
  
  choose_repository
  
  echo "Cloning repository $REPO_NAME into the container..."
  docker exec -it $container_name bash -c "cd $project_directory && git clone https://github.com/$REPO_NAME.git"
  
  setup_webhook
}

setup_webhook() {
  echo "Setting up GitHub webhook for auto-deploy..."
  curl -s -X POST -H "Authorization: token $github_token" -d '{
    "config": {
      "url": "http://localhost:8080/deploy",
      "content_type": "json"
    },
    "events": ["push"]
  }' $GITHUB_API_HOOKS$REPO_NAME/hooks
}

run_deploy_script() {
  echo "Setting up auto-deploy for repository $REPO_NAME..."
  docker exec -it $container_name bash -c "cd $project_directory/$REPO_NAME && git pull origin master"
}

show_menu() {
  echo "Select an action:"
  echo "1) Deploy a Git repository"
  echo "2) Run deploy script (Git pull)"
  echo "3) Exit"
}

while true; do
  show_menu
  read -p "Enter your choice: " choice
  case $choice in
    1)
      deploy_git_repo
      ;;
    2)
      run_deploy_script
      ;;
    3)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid choice, please try again."
      ;;
  esac
done
