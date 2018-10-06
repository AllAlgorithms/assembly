#include <stdio.h>
#include <string.h>

int kmp(char *text, char *search_string);

int main(int argc, char **argv){

	if(argc != 2){
		printf("Invalid command line arguments\n");
		return -1;
	}
	

	char *text = argv[1];
	
	
	printf("Search pattern: ");
	char search_string[strlen(text)];
	fscanf(stdin, "%s", search_string);
	
	printf("Prefix table:\n");
	int first_position	= kmp (text, search_string);
	
	printf("\n");
	if(first_position==101)
		printf("The search pattern could not find in the text.\n");
	else
		printf("First position: %d (index starting from 0)\n", first_position);

	return(0);
}

