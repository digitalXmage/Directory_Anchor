#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include"../config/config.h"
#define bashrc ".bashrc\0"
#define anchor ".anchor\0"

/*Create the fullpath to files, we need the user's hostname to locate the files we want
 * @directory - where the constructed directory will be stored
 * @filename - the name of the file we want in the user's main directory*/
void construct_directory(char *directory,char *filename)
{
	sprintf(directory,"/home/%s/%s",getlogin(),filename);
}


/*Create the alias string and save to .bashrc
 * @directory - the directory the user wants to create an alias anchor to*/
void create_anchor_alias(char *directory)
{
	/*generate the .bashrc location for the user's machine*/
	char bashrc_location[100]; construct_directory(bashrc_location,bashrc);
	
	/*open .bashrc in append mode*/
	FILE *fd = fopen(bashrc_location,"a+");
	if(fd==NULL)
	{
		char error[100]; sprintf(error,"fopen(%s):",bashrc_location);
		perror(bashrc_location);
		exit(EXIT_FAILURE);
	}

	/*generate the anchor to save as an alias in bashrc*/
	char alias[100]; sprintf(alias,"alias %s=\"cd %s\"\n",alias_key,directory);
//	printf("saving = %s\n\n",alias);

	/*append the alias to .basrch*/
	fprintf(fd,"%s",alias);
	

	/*save alias as reference for deletion in .anchor_point*/
	/*generate the .anchor location for the user's machine*/
	char anchor_location[100]="\0"; construct_directory(anchor_location,anchor);
	FILE *fd2 = fopen(anchor_location,"w+");
	if(fd2==NULL)
	{
		char error[100]; sprintf(error,"fopen(%s)",anchor_location);
		perror(anchor_location);
		exit(EXIT_FAILURE);
	}

	/*append the alias reference to .anchor (for reference when deleting from bashrc later)*/	
	fprintf(fd2,"%s",alias);

	/*close file descriptors*/
	if(fclose(fd2)!=0)
	{
		char error[100];sprintf(error,"fclose(%s)",anchor_location);
		perror(error);
		exit(EXIT_FAILURE);
	}
	if(fclose(fd)!=0)
	{
		char error[100];sprintf(error,"fclose(%s)",bashrc_location);
		perror(error);
		exit(EXIT_FAILURE);
	}
	
	
}
/*get the saved alias for reference check when deleting from .bashrc
 * @alias_store - where we will store the alias string loaded from .anchor reference file*/
void load_saved_alias(char *alias_store)
{
	char anchor_location[100]="\0"; construct_directory(anchor_location,anchor); 
	FILE *fd = fopen(anchor_location,"r");
	if(fd==NULL)
	{
		char error[100];sprintf(error,"fopen(%s):",anchor_location);
		perror(anchor_location);
		exit(EXIT_FAILURE);
	}
	char alias[100]="\0";
	fgets(alias,sizeof(alias),fd);
	fclose(fd);
	sprintf(alias_store,"%s",alias);

	
}
/*Remove the alias from .bashrc
 * @alias - is used as a reference to check if .bashrc contains the alias for deletion or not*/
void remove_anchor_alias(char *alias)
{
	char buf[1000] = "";
	int exists = 0;
	char string[100];

	/*obtain the alias to remove from the file*/
	strcpy(string,alias);



	/*construct the bashrc location and open*/
	char bashrc_location[100]="\0"; construct_directory(bashrc_location,bashrc);
	FILE *fd = fopen(bashrc_location,"r");
	if(fd==NULL)
	{
		char error[100]; sprintf(error,"fopen(%s):",bashrc_location);
		perror(error);
		exit(EXIT_FAILURE);
	}
	/*construct the temp location and open file, for where we will temporary store the contents of .bashrc*/
	char temp_location[100]="\0"; construct_directory(temp_location,"temp");
	FILE *fd2 = fopen(temp_location,"a+");
	if(fd2==NULL)
	{
		char error[100]; sprintf(error,"fopen(%s):",temp_location);
		perror(error);
		exit(EXIT_FAILURE);
	}
	rewind(fd);
	/*initial check for the alias to delete, if it does not exist then theres no need to do all this*/
	while(fgets(buf,sizeof(buf),fd))
	{

		if(strcmp(buf,alias)==0)
		{
			//printf("alias exists in the file to delete\n");
			exists = 1;
		}
	
	} /*if the alias we want to delete exists, then read through bashrc again and store all the contents
	of .bashrc into the temp file execpt the alias to delete itself, thus creating a new bashrc without
	the alias*/ 
	if(exists ==1){
		rewind(fd);
		while(fgets(buf,sizeof(buf),fd))
		{ 
			if(strcmp(buf,alias)!=0)
			{
				fprintf(fd2,"%s",buf);
			}
		}
	/*then go back to the top of the newly written temp file, remove .bashrc and open a new .bashrc
	 * and then read the entire temp file and write all the newly written contents to our new .bashrc file.
	 * Once done, we remove the temp file, thus essentially copying the temp file to a new .bashrc*/
		rewind(fd2);
		fclose(fd);
		remove(bashrc_location);
		fd = fopen(bashrc_location,"a+");
		while(fgets(buf,sizeof(buf),fd2))
		{
			fprintf(fd,"%s",buf);
		}
		fclose(fd2);
		fclose(fd);
		remove(temp_location);
		}

}


int main(int argc,char *argv[])
{
	char alias_string[100]; //the storage location of the current alias, which 2/3 of functions rely upon
	int arguments = 0; //boolean check for arguments

	/*if argc = 1, then set no_args = true and this will control which if-statement gets executed*/	
	if(argc>1)
		arguments += 1;


	if(arguments == 1){
		/*if you want to supply a custom directory to anchor*/
		if(strcmp(argv[1],"a")==0)
		{

			/*overrite any existing anchor with a new anchor*/
			load_saved_alias(alias_string);
			remove_anchor_alias(alias_string);
		
			create_anchor_alias(argv[2]);
			printf("*directory anchored*\n");
		}/*print current anchor*/
		if(strcmp(argv[1],"p")==0)
		{
			load_saved_alias(alias_string);
			printf("current anchor:%s\n",alias_string);
		}
	}	
	else /*if no arguments supplied, then we anchor the directory the program was called in.*/
	{
		char directory[100]="\0";
		if(getcwd(directory,sizeof(directory))==NULL)
		{
			perror("getcwd():");
			exit(EXIT_FAILURE);
		}
		/*overrite any existing anchor with a new anchor*/	
		load_saved_alias(alias_string);
		remove_anchor_alias(alias_string);

		create_anchor_alias(directory);
		printf("*directory anchored*\n");	
	}

	return 0;
}
