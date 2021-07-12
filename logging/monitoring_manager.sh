########################
#  Monitoring-Manager
#
# Author : Zenika Bordeaux
# Date : 12-07-2021
# Goal : Handle Monitoring (Start - Stop - Status - Restart)
########################

#!/bin/sh


###############################################
####        Variables & Constants
###############################################

# Déclaration des constantes systèmes
SCRIPT_TITLE=$(basename $0)

# Déclaration des variables du programme
COMPOSE_FILE="docker-compose.yml"
todo="$1"


###############################################
####            Usage function
###############################################

Usage () {
echo ""
echo "Usage: ./$SCRIPT_TITLE [ start / stop / status / restart ]"
echo "       Info - Le fichier $COMPOSE_FILE doit être dans la même arborescence."
echo " "
exit 1
}

###############################################
####            Prerequires
###############################################

# Only one Argument
if [ $# -ne 1 ]
then
  Usage
fi

# Compose file Exists
if [ ! -f $COMPOSE_FILE ]
then
  Usage
fi

###############################################
####            Functions
###############################################

# Start
Start_tool () {
 docker-compose \-f $COMPOSE_FILE up -d
}

# Stop
Stop_tool() {
 docker-compose \-f $COMPOSE_FILE down
}

# Status
Check_status () {
 docker-compose \-f $COMPOSE_FILE ps | grep --color=auto -E 'Up|Exit|Down'
}

# Restart
Restart_tool() {
 Stop_tool
 echo ""
 sleep 2
 Start_tool
}


###############################################
####            Main Program
###############################################

  case $todo in
        start)
                    Start_tool;
            ;;
        stop)
                    Stop_tool;
            ;;
        status)
                    Check_status;
            ;;
        restart)
                    Restart_tool;
            ;;
        *) echo "${RED}Erreur de choix: $todo${NC}";
           Usage;
        ;;
  esac
