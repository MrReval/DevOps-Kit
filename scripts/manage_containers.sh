#!/bin/bash

# نمایش لیست کانتینرهای در حال اجرا
list_containers() {
  echo "Listing all running Docker containers..."
  docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}"
}

# اتصال به گیت‌هاب و دریافت ریپازیتوری‌ها
connect_git() {
  echo "Please enter your GitHub username: "
  read github_user
  echo "Please enter your GitHub token (Personal Access Token): "
  read -s github_token
  
  # دریافت لیست ریپازیتوری‌ها از گیت‌هاب
  repositories=$(curl -s -H "Authorization: token $github_token" "https://api.github.com/users/$github_user/repos" | jq -r '.[].full_name')
  
  echo "Available repositories:"
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

# کلون کردن ریپازیتوری به داخل کانتینر
clone_repo_to_container() {
  echo "Please enter the container name or ID: "
  read container_id
  echo "Please enter the project directory inside the container (e.g., /app): "
  read project_directory
  
  # کلون کردن ریپازیتوری داخل کانتینر
  docker exec -it $container_id bash -c "cd $project_directory && git clone https://github.com/$REPO_NAME.git"
  echo "Repository $REPO_NAME cloned to $container_id at $project_directory"
}

# اتصال دامنه به کانتینر
attach_domain_to_container() {
  echo "Please enter the container ID: "
  read container_id
  echo "Please enter the domain to attach: "
  read domain
  
  # اطمینان از این که کانتینر در حال اجراست
  container_status=$(docker inspect -f '{{.State.Running}}' $container_id)
  
  if [ "$container_status" != "true" ]; then
    echo "The container is not running. Please start the container first."
    exit 1
  fi

  echo "Attaching domain $domain to container $container_id..."

  # مسیر پیکربندی Nginx یا Apache (بسته به انتخاب کاربر)
  echo "Please select the web server you are using (1: Nginx, 2: Apache): "
  read web_server_choice

  case $web_server_choice in
    1)
      # تنظیم دامنه برای Nginx
      echo "Configuring Nginx for domain $domain"
      config_file="/etc/nginx/sites-available/$domain"
      echo "server {
        listen 80;
        server_name $domain;
        
        location / {
          proxy_pass http://$container_id:80;
          proxy_set_header Host \$host;
          proxy_set_header X-Real-IP \$remote_addr;
          proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        }
      }" > $config_file
      ln -s $config_file /etc/nginx/sites-enabled/
      nginx -s reload
      echo "Nginx configuration for domain $domain has been updated."
      ;;
    2)
      # تنظیم دامنه برای Apache
      echo "Configuring Apache for domain $domain"
      config_file="/etc/apache2/sites-available/$domain.conf"
      echo "<VirtualHost *:80>
        ServerName $domain
        DocumentRoot /var/www/html
        ProxyPass / http://$container_id/
        ProxyPassReverse / http://$container_id/
      </VirtualHost>" > $config_file
      a2ensite $domain.conf
      systemctl reload apache2
      echo "Apache configuration for domain $domain has been updated."
      ;;
    *)
      echo "Invalid choice. Please select either 1 for Nginx or 2 for Apache."
      exit 1
      ;;
  esac

  # به کاربر اطلاع دادن از وضعیت
  echo "Domain $domain has been successfully attached to container $container_id."
}

# منوی اصلی
show_menu() {
  echo "Select an action:"
  echo "1) List running containers"
  echo "2) Connect to GitHub and deploy repository"
  echo "3) Attach domain to container"
  echo "4) Exit"
}

# اجرای منو
while true; do
  show_menu
  read -p "Enter your choice: " choice
  case $choice in
    1)
      list_containers
      ;;
    2)
      connect_git
      clone_repo_to_container
      ;;
    3)
      attach_domain_to_container
      ;;
    4)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid choice, please try again."
      ;;
  esac
done
