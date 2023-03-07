#! /bin/awk -f

#when init bindings, need to print the text except
#if we have any alias matches then we don't, so will
#need to maybe have this as a seperate function maybe,
#a custom write with an argument of what to ignore
#so we can run it in the END block
function iprint()
{
	#need to ignore aliases with a colum set to a number

#	if($1!="alias" && ($2!="1"))
#	{
#		print $0
#	}

	#this seems to work however when i do an inverse match it doesn't work
	#this inverse works , maybe something to do with = vs ~
	#place in a temp file and compare with diff to make sure it's not
	#cutting anything off,seems to only be cutting off, when outputting
	#and reading itself onto itself, so I GUESs awk doesn't map the 
	#entire text file into memory i see. Thus will need to output 
	#to a temp file and in the END block of the iterative read
	#we then cp the files over using some sort of inbuilt system
	#command
	if(!($1=="alias" && ($2~"1"||$2~"2"||$2~"3"||$2~"4"||$2~"5")))
	{
		print $0 > "output.txt"  #test
	}

}

#overrite the read file with the updated file contents somehow
function overrite_file()
{
	#output file to tmp file, and then execute a system command
	#to copy the temp file to the old file, and remove the temp file
	#see if we can output onto itself, because I would assume, awk
	#would map the entire file into memory thus we should be able
	#to overrite it, especially at the end onto the hdd, especially 
	#if we're strictly completely in memory, thus less operations
	#overall.

	
}


function init_bindings()
{

	#backup the .bashrc file as well
		for(i=1;i<=5;i++)
		{
			printf("alias %d=\"\"\n",i)
		}
		#print $0
	
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
		#print $0
		iprint();
	}
}
END{if(ZARGV[1]=="i"){init_bindings()}}
