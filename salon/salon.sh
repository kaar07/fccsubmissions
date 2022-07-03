#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"

:`
MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  fi

  echo -e "\n1.Make an appointment.\n2.Cancel my appointment.\n3.I'll come back later!"
  read OPTION

  case $OPTION in
    1) MAKE;;
    2) CANCEL;;
    3) EXIT;;
    *) MAIN_MENU "Enter a valid Option.";;
  esac
}
`

MAKE(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nThese services are offered here: "
  fi
  SERVICES_AVAIL=$($PSQL "SELECT * FROM services")
  echo "$SERVICES_AVAIL" | while read SER_ID BAR SERVICE
  do
    echo "$SER_ID) $SERVICE"
  done
  read SERVICE_ID_SELECTED
  if [[ !  $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAKE "Enter a valid number corresponding to the service you want.\nWhat would you like today?"
  else
    SER_REQ=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    if [[ -z $SER_REQ ]]
    then
      MAKE "I could not find that service.\nWhat would you like today?"
    else
      echo -e "What's your phone number?"
      read CUSTOMER_PHONE
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_ID ]]
      then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        NAME_ENTRY_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
      fi
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      echo -e "\nWhat time would you like to $(echo $SER_REQ | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
      read SERVICE_TIME
      MAKE_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED,'$SERVICE_TIME')")
      if [[ $MAKE_RESULT == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $(echo $SER_REQ | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
      else
        echo -e "\nCouldn't make your appointment!"
      fi
      EXIT
    fi
  fi
}

CANCEL(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
    MAIN_MENU "I couldn't find a record for that phone number."
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id=$CUSTOMER_ID")
    echo -e "\n$CUSTOMER_NAME, You have these appointments :\n"
    APPOINTMENTS=$($PSQL "SELECT appointment_id,name,SERVICE_TIME FROM appointments INNER JOIN services USING(service_id) WHERE customer_id=$CUSTOMER_ID ORDER BY service_id")
    echo "$APPOINTMENTS" | while read APP_ID BAR SERVICE BAR SERVICE_TIME
    do
      echo "($APP_ID) $SERVICE at $SERVICE_TIME"
    done
    echo -e "\nEnter the ID corresponding to the appointment you want to cancel ..."
    read TO_CANCEL_ID
    CANCEL_RESULT=$($PSQL "DELETE FROM appointments WHERE appointment_id=$TO_CANCEL_ID")
    echo -e "\nI have cancelled your appointment.\nWould you like to make another one?\n1. Yes\n2. No"
    read input
    if [[ $input == 1 ]]
    then
      MAKE "Lets get you a new appointment then!"
    else
      EXIT
    fi
  fi
}

EXIT(){
  echo -e "\nThanks for coming by. Hope to see you soon!\n"
}

MAKE
