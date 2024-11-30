#!/bin/bash

show_menu() {
  echo -e "\e[32m1) PHP / Apache\e[0m"
  echo -e "\e[34m2) Laravel\e[0m"
  echo -e "\e[35m3) Python\e[0m"
  echo -e "\e[36m4) Django\e[0m"
  echo -e "\e[33m5) Flask\e[0m"
  echo -e "\e[31m6) React.js\e[0m"
  echo -e "\e[37m7) Next.js\e[0m"
  echo -e "\e[32m8) Node.js / Nginx\e[0m"
  echo -e "\e[34m9) Angular\e[0m"
  echo -e "\e[35m10) Vue.js\e[0m"
  echo -e "\e[36m11) Static Website\e[0m"
  echo -e "\e[33m12) Custom Docker\e[0m"
  echo -e "\e[32mDB Options:\e[0m"
  echo -e "\e[34m13) MySQL\e[0m"
  echo -e "\e[35m14) MongoDB\e[0m"
  echo -e "\e[36m15) Redis\e[0m"
  echo -e "\e[37m16) phpMyAdmin\e[0m"
  echo -e "\e[32m17) List of Applications\e[0m"
  echo -e "\e[34m18) Create New Application\e[0m"
  echo -e "\e[31m19) Manage Applications\e[0m"
  echo -e "\e[36m20) Resource Usage Report\e[0m"
}

create_container() {
  echo "Please select a platform: "
  show_menu
  read choice
  case $choice in
    1) create_php_apache ;;
    2) create_laravel ;;
    3) create_python ;;
    4) create_django ;;
    5) create_flask ;;
    6) create_react ;;
    7) create_nextjs ;;
    8) create_node_nginx ;;
    9) create_angular ;;
    10) create_vue ;;
    11) create_static_website ;;
    12) create_custom_docker ;;
    13) create_mysql ;;
    14) create_mongodb ;;
    15) create_redis ;;
    16) create_phpmyadmin ;;
    17) list_applications ;;
    18) create_new_application ;;
    19) manage_applications ;;
    20) show_resource_usage ;;
    *) echo "Invalid selection. Please try again." ;;
  esac
}

create_php_apache() {
  echo "Setting up PHP / Apache container..."
  MYSQL_USER="root"
  MYSQL_PASS=$(openssl rand -base64 12)
  docker run --name php-apache-container -d -e MYSQL_ROOT_PASSWORD="$MYSQL_PASS" php:7.4-apache
  echo "PHP / Apache container successfully created."
  echo "Container URL: http://localhost:80"
  echo "Root user: $MYSQL_USER"
  echo "Random password: $MYSQL_PASS"
}

create_laravel() {
  echo "Setting up Laravel container..."
  docker run --name laravel-container -d -p 8000:8000 laravel:latest
  echo "Laravel container successfully created."
  echo "Container URL: http://localhost:8000"
}

create_python() {
  echo "Setting up Python container..."
  docker run --name python-container -d python:3.9
  echo "Python container successfully created."
}

create_django() {
  echo "Setting up Django container..."
  docker run --name django-container -d -p 8000:8000 django:latest
  echo "Django container successfully created."
  echo "Container URL: http://localhost:8000"
}

create_flask() {
  echo "Setting up Flask container..."
  docker run --name flask-container -d -p 5000:5000 flask:latest
  echo "Flask container successfully created."
  echo "Container URL: http://localhost:5000"
}

create_react() {
  echo "Setting up React.js container..."
  docker run --name react-container -d -p 3000:3000 react:latest
  echo "React.js container successfully created."
  echo "Container URL: http://localhost:3000"
}

create_nextjs() {
  echo "Setting up Next.js container..."
  docker run --name nextjs-container -d -p 3000:3000 nextjs:latest
  echo "Next.js container successfully created."
  echo "Container URL: http://localhost:3000"
}

create_node_nginx() {
  echo "Setting up Node.js / Nginx container..."
  docker run --name node-nginx-container -d -p 8080:80 node:14-alpine
  echo "Node.js / Nginx container successfully created."
  echo "Container URL: http://localhost:8080"
}

create_angular() {
  echo "Setting up Angular container..."
  docker run --name angular-container -d -p 4200:4200 angular:latest
  echo "Angular container successfully created."
  echo "Container URL: http://localhost:4200"
}

create_vue() {
  echo "Setting up Vue.js container..."
  docker run --name vue-container -d -p 8080:8080 vue:latest
  echo "Vue.js container successfully created."
  echo "Container URL: http://localhost:8080"
}

create_static_website() {
  echo "Setting up Static Website container..."
  docker run --name static-website-container -d -p 80:80 nginx:latest
  echo "Static Website container successfully created."
  echo "Container URL: http://localhost"
}

create_custom_docker() {
  echo "Please enter the custom Docker image name:"
  read custom_image
  echo "Setting up custom Docker container..."
  docker run --name custom-container -d $custom_image
  echo "Custom Docker container successfully created."
}

create_mysql() {
  MYSQL_PASS=$(openssl rand -base64 12)
  docker run --name mysql-container -d -e MYSQL_ROOT_PASSWORD="$MYSQL_PASS" mysql:5.7
  echo "MySQL container successfully created."
  echo "Container URL: mysql://localhost:3306"
  echo "Root user: root"
  echo "Random password: $MYSQL_PASS"
}

create_mongodb() {
  echo "Setting up MongoDB container..."
  docker run --name mongodb-container -d -p 27017:27017 mongo:latest
  echo "MongoDB container successfully created."
  echo "Container URL: mongodb://localhost:27017"
}

create_redis() {
  echo "Setting up Redis container..."
  docker run --name redis-container -d -p 6379:6379 redis:latest
  echo "Redis container successfully created."
  echo "Container URL: redis://localhost:6379"
}

create_phpmyadmin() {
  echo "Setting up phpMyAdmin container..."
  docker run --name phpmyadmin-container -d -p 8081:80 phpmyadmin/phpmyadmin
  echo "phpMyAdmin container successfully created."
  echo "Container URL: http://localhost:8081"
}

list_applications() {
  echo "Listing all applications..."
  docker ps
}

create_new_application() {
  echo "Creating a new application..."
}

manage_applications() {
  echo "Managing applications..."
}

show_resource_usage() {
  echo "Fetching resource usage statistics..."
  docker stats --no-stream
}

create_container
