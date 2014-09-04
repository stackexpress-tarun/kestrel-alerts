
FILENAME="telnet_output"
FOLDERNAME=kestrel-script
PATH=/home/stackexpress/

/bin/touch $PATH$FOLDERNAME/$FILENAME

cd $PATH$FOLDERNAME
#Put data into file
./telnet_command.sh > $PATH$FOLDERNAME/$FILENAME

#Parse data into the file
DATAFILE=all_alerts
/bin/touch $PATH$FOLDERNMAE$DATAFILE

/usr/bin/ruby parse_data.rb

#Find difference between two files and generate out of difference
/bin/grep -Fxvf present_alerts all_alerts > pending_alerts

#Create json files from the above output
/bin/rm -rf json
JSONFOLDER="json"
/bin/mkdir $PATH$FOLDERNAME/$JSONFOLDER

/usr/bin/ruby create_json_files.rb

#zip and mail the folder 
/usr/bin/zip -r pending_alerts $PATH$FOLDERNAME

/usr/bin/ruby mail.rb
