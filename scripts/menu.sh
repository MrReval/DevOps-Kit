#!/bin/bash

# تغییر مسیر به دایرکتوری اصلی پروژه
cd "$(dirname "$0")/.." || exit

# تابع نمایش منو
menu() {
  echo -e "\e[35m1) =| CreateContainer\e[0m"
  echo -e "\e[36m2) =| ConnectToGitRepo\e[0m"
  echo -e "\e[36m3) =| ManageContainer\e[0m"
  echo -e "\e[33m4) =| ContainerUsageReport\e[0m"
}

# تابع مدیریت انتخاب‌ها
itemlist() {
  echo "Please select an item: "
  menu
  read -p "Enter your choice: " choice
  case $choice in
    1) CreateContainer ;;
    2) ConnectToGitRepo ;;
    3) ManageContainer ;;
    4) ContainerUsageReport ;;
    *) echo "Invalid selection. Please try again." ;;
  esac
}

# تعریف توابع

CreateContainer() {
  if [ -f "./scripts/create_container.sh" ]; then
    bash ./scripts/create_container.sh
  else
    echo "Error: create_container.sh not found!"
  fi
}

ConnectToGitRepo() {
  if [ -f "./scripts/git_deploy.sh" ]; then
    bash ./scripts/git_deploy.sh
  else
    echo "Error: git_deploy.sh not found!"
  fi
}

ManageContainer() {
  if [ -f "./scripts/manage_containers.sh" ]; then
    bash ./scripts/manage_containers.sh
  else
    echo "Error: manage_containers.sh not found!"
  fi
}

ContainerUsageReport() {
  if [ -f "./scripts/resource_report.sh" ]; then
    bash ./scripts/resource_report.sh
  else
    echo "Error: resource_report.sh not found!"
  fi
}

# اجرای منو
itemlist
