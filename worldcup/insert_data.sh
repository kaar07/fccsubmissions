#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
  if [[ $YEAR != year ]]
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # if not present add winner to teams
    if [[ -z $WINNER_ID ]]
    then
      WINNER_ADD_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $WINNER_ADD_RESULT == "INSERT 0 1" ]]
      then
        echo "$WINNER added to teams."
      fi 
    fi
    # get new winner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # get opponent_id
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # if not present add opponent to teams
    if [[ -z $OPP_ID ]]
    then
      OPP_ADD_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $OPP_ADD_RESULT == "INSERT 0 1" ]]
      then
        echo "$OPPONENT added to teams."
      fi
    fi
    # get new opponent id
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # add info to teams
    GAME_ADD_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPP_ID,$WIN_GOALS,$OPP_GOALS)")
    if [[ $GAME_ADD_RESULT == "INSERT 0 1" ]]
    then
      echo "A game in $YEAR of $ROUND round is added."
    fi
  fi
done 
