#!/bin/bash

#PSQL variable for database access
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# function INSERT INTO game archives in databases.
INSERT_DATA(){
  # two arguments are given. user_id and guesses_taken
  INSERT_RESULT=$($PSQL "INSERT INTO games VALUES($1,$2)")
}

# the game function
GAME(){
  # single argument user_id
  NUM=0
  COUNT=0
  RANDOM_NUMBER=$(( $RANDOM % 1000 + 1))
  while [[ $NUM -ne $RANDOM_NUMBER ]]
  do
    read NUM
    if [[ ! $NUM =~ ^[0-9]+$ ]]
    then
      echo -e "That is not an integer, guess again:"
    else
      if [[ $NUM -gt $RANDOM_NUMBER ]]
      then
        echo -e "It's lower than that, guess again:"
      elif [[ $NUM -lt $RANDOM_NUMBER ]]
      then
        echo -e "It's higher than that, guess again:"
      fi
      COUNT=$((COUNT+1))
    fi
  done
  echo -e "You guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
  INSERT_DATA $1 $COUNT
}


# Querying the name
echo -e "Enter your username:"
read NAME
ID_DB=$($PSQL "SELECT user_id FROM users WHERE name='$NAME'")
if [[ -z $ID_DB ]]
then
  echo -e "Welcome, $NAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(name) VALUES('$NAME')")
  ID_DB=$($PSQL "SELECT user_id FROM users WHERE name='$NAME'")
else
  PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$ID_DB")
  BEST=$($PSQL "SELECT guesses FROM games WHERE user_id=$ID_DB ORDER BY guesses ASC LIMIT 1")
  echo -e "Welcome back, $NAME! You have played $PLAYED games, and your best game took $BEST guesses."
fi
echo -e "Guess the secret number between 1 and 1000:"
GAME $ID_DB
