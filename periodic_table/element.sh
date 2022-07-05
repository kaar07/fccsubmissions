#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


PRINT(){
  # Atomic number is the standard input to give details. $1
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  SYM=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  AMASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
  echo -e "The element with atomic number $1 is $(echo $NAME |sed -r 's/^ *| *$//g') ($(echo $SYM | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE|sed -r 's/^ *| *$//g'), with a mass of $(echo $AMASS|sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $MP|sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BP|sed -r 's/^ *| *$//g') celsius."
}

# check if an argument is passed
if [[ $1 ]]
then
  # check if passed argument is a number
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    # check if there's an atomic number corresponding to given argument as symbol
    ATOMIC_NUMBER_SYM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    # if doesn't correspond to a symbol
    if [[ -z $ATOMIC_NUMBER_SYM ]]
    then
      # check if there's an atomic number corresponding to given argument as name
      ATOMIC_NUMBER_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
      # if doesn't correspond to name (and symbol)
      if [[ -z $ATOMIC_NUMBER_NAME ]]
      then
        echo -e "I could not find that element in the database."
      else
        PRINT $ATOMIC_NUMBER_NAME
      fi
    else
      PRINT $ATOMIC_NUMBER_SYM
    fi
  else
    # check if numbered argument is a valid atomic number
    ATOMIC_NUMBER_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    if [[ -z $ATOMIC_NUMBER_NUM ]]
    then
      # not available message
      echo -e "I could not find that element in the database."
    else
      PRINT $ATOMIC_NUMBER_NUM
    fi
  fi
else
  echo -e "Please provide an element as an argument."
fi
