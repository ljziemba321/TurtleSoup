typedef struct entrytype entry;
typedef entry *entrylink;
struct entrytype
{
	char name[20];
	int type; //1 is turtle, 2 is variable, 3 is instinct
	entrylink ptr;
};



entrylink head = NULL; //head must start equal to null or program will not function as intended

void addTab(char *str, int newtype)
{
	int len, typecheck;
	entrylink newentry;
	typecheck = inTab(str);
	if(typecheck == 0) //Checking for duplicates
	{
		len = strlen(str);
		if(len > 0 && len < 20 && newtype > 0 && newtype <= 3) //must be bewteen 0-20 in length and have a type 1-3
		{	 
			newentry = malloc(sizeof(entry));
			if(newentry != NULL) //checking for sucess of malloc
			{
				newentry->type = newtype;
				strcpy(newentry->name, str);
				newentry->ptr = head;
				head = newentry;
			}
			else
			{
				printf("Error allocating memory, quitting\n");
				exit(1);
			}
		}
		else
		{
			printf("Invalid table entry, not entered in page table\n");
		}
	}
	else
	{	if(typecheck == 1)
			printf("Variable %s already in table of TURTLE type, redeclaration not allowed\n", str);
		if(typecheck == 2)
			printf("Variable %s already in table of INTEGER type, redeclaration not allowed\n", str);
		if(typecheck == 3)
			printf("Variable %s already in table of INSTINCT type, redeclaration not allowed\n", str);		
		exit(1);
	}
}

int inTab(char *str)
{
	entrylink tmp;
	tmp = head;
	while(tmp != NULL)
	{
	if (strcmp(tmp->name, str) == 0) //checking if current entry's string is the same as the input
		return tmp->type; //returning type as a success code
	else
		tmp = tmp->ptr;
	}
	return 0;
}

void printTab()
{
	entrylink tmp;
	tmp = head;
	while(tmp != NULL)
	{
		printf("%s, %d\n", tmp->name, tmp->type);
		tmp = tmp->ptr;
	}
}

