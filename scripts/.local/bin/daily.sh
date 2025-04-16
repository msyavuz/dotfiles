# This script is intended to be run daily to check for updates and perform maintenance tasks.


# Create daily notes file
current_date=$(date +%d-%m-%Y)
daily_note_path="$HOME/Notes/Daily/$current_date.md"
template="# TODOS\n - [ ]\t"

if ! [ -e $daily_note_path ]; then
  touch $daily_note_path
  echo -e $template  >> $daily_note_path
else
  echo "Daily note already exists"
fi
