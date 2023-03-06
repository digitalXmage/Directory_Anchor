#! /bin/awk -f

function init_bindings()
{

#when initing the script, we need to make sure to remove the prior anchor numbers
#or at least update them if they exist, however this runs to prepare the file
#in order for the program to work correctly.

#so if we come accross any of the alias numbers, then change them to blank,otherwise
#just print a new string

#	print $0
#	counter++
#	print eof
#	if(counter=eof){

#	if($1=="alias")
#	{
#		
#		if($2~"1"||$2~"2"||$2~"3"||$2~"4"||$2~"5")
#		{
#			print $0 #woud this print a blank as opposed to the current alias, or would
				   #it print this and the alias....
			
#		}
#	}

	#backup the .bashrc file as well
		for(i=1;i<=5;i++)
		{
			printf("alias %d=\"\"\n",i)
		}
		#print $0
		#print "hello friend"
		#could check a built in variable to see if we're at the end and then
		#print the blank aliases into the file, thus adding them into the script
		#that way

#	}
}

function list_bindings()
{
	if($1=="alias")
	{
		if($2~"1"||$2~"2"||$2~"3"||$2~"4"||$2~"5")
		{
			print $0
		}
	}
}

function add_binding(number,replacement)
{

	if($1=="alias" && $2~number){

		#next
		printf("alias %d=\"%s\"\n",number,replacement)
		#printf("alias %d=\"%s\"\n",3,"TESTING")
	 # $0 = "REPLACEMENT for alias 2"

	} 
	else{
		print $0
	}

	#doesn't seem ot be working here.
		
}

#list and add_binding seem to work as expeced Just need to store
#them in a temp file and copy accross at some point. OR find a 
#way to edit in place. However I think for add binding to exist
#the alias number has to already exist in the text. THUS logically
#if we don't find the alias, then we need to create it or create
#them pre-emptively, maybe have a setup function, which runs first,
#which also backs up the .bashrc etc. For sake of simplicity
#let's just create an init function to run first before using the program

BEGIN{ZARGV[1]=ARGV[1];ARGV[1]="/home/sam/.bashrc";}\
{
	if(ZARGV[1]=="l"){
		list_bindings()

	}

	if(ZARGV[1]=="a")
	{
#		print $0 maybe add the toggle logic out here, if it's leaving
		#and continuing reading perhaps?
		add_binding(2,"HELLO")
	}

	if(ZARGV[1]=="i")
	{
		#waits to end to then add the new bindings to the bashrc file
		#init_bindings()
		print $0
	}
}
END{if(ZARGV[1]=="i"){init_bindings()}}
