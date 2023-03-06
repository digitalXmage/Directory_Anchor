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
		for(i=1;i<=5;i++)
		{
			printf("alias %d=\"\"\n",i)
		}
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

function add_binding(number,replacement,toggle)
{
	if($1=="alias" && $2~number){

		#next
		printf("alias %d=\"%s\"\n",number,replacement)
		#printf("alias %d=\"%s\"\n",3,"TESTING")
	 # $0 = "REPLACEMENT for alias 2"

	} #else create the alias and print that string with rest of file
	#if this executes, need a toggle to only run once, and not continuously
	#throughout the iterative reading of the file.
	else{
			

		if(toggle=="0"){
			#print $0
			printf("alias %d=\"%s\"\n",number,replacement)
			toggle=1	#see if this is allowed
		}
		#print $0
	}
	print $0
	#and append to eof

	#doesn't seem ot be working here.
		
}

#list and add_binding seem to work as expeced Just need to store
#them in a temp file and copy accross at some point. OR find a 
#way to edit in place. However I think for add binding to exist
#the alias number has to already exist in the text. THUS logically
#if we don't find the alias, then we need to create it or create
#them pre-emptively, maybe have a setup function, which runs first,
#which also backs up the .bashrc etc.

BEGIN{ZARGV[1]=ARGV[1];ARGV[1]="/home/sam/.bashrc";ZARGV[2]="0";}\
{
	if(ZARGV[1]=="l"){
		list_bindings()

	}

	if(ZARGV[1]=="a")
	{
#		print $0
		add_binding(2,"HELLO",ZARGV[2])
	}

	if(ZARGV[1]=="i")
	{
		print $0
	}
}
END{if(ZARGV[1]=="i"){init_bindings()}}
