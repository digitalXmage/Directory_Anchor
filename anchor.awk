#! /bin/awk -f

function init_bindings()
{

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


#could redirect it into a temp file, and then at the end, read that file back
#into the .bashrc see if that's possible to do within itself,

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
