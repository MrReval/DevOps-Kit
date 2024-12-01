#!/bin/bash

menu() {

  echo -e "\e[35m10) =| CreateContainer\e[0m"
  echo -e "\e[36m20) =| ConnectToGitRepo\e[0m"
  echo -e "\e[36m11) =| ManageContainer\e[0m"
  echo -e "\e[33m12) =| ContainerUsageReport\e[0m"
}

itemlist() {
  echo "Please select a item: "
  menu
  read choice
  case $choice in
    1) CreateContainer ;;
    2) ConnectToGitRepo ;;
    3) ManageContainer ;;
    4) ContainerUsageReport ;;

    *) echo "Invalid selection. Please try again." ;;
  esac
}


CreateContainer(){
    ./scripts/create_container.sh
}
CreateContainer(){
    ./scripts/manage_containers.sh
}
CreateContainer(){
    ./scripts/resource_report.sh
}
ConnectToGitRepo(){
    ./scripts/git_deploy.sh

}
itemlist