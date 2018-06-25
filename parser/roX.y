%{
#include <stdio.h>
void yyerror(const char *s);
int yylex();

%}

%error-verbose

%union 
{
        int number;
        char *string;
        char character;
        float floatValue;
}

%token <number> INTEGER;
%token <string> STRING;
%token <string> CHARACTER;
%token <floatValue> FLOAT;
%token TRUE;
%token FALSE;
%token INT_VAR;
%token FLOAT_VAR;
%token DIEGO;
%token STRING_VAR;
%token CHAR_VAR;
%token <string> VAR_NAME;
%token IF;					
%token ELSE;
%token DO; 					
%token WHILE; 
%token FOR;
%token SWITCH;
%token CASE;
%token DEFAULT;
%token BREAK;				
%token OPEN_PARENTHESIS;
%token CLOSE_PARENTHESIS;
%token OPEN_BRACKET;
%token CLOSE_BRACKET;
%token ASSIGNATION;
%token ADD;
%token SUB;
%token DIV;
%token MULTIPLY;
%token MODULO;
%token INCREMENT;
%token DECREMENT;
%token OR;
%token AND;
%token NEGATIV;
%token LOWERTHAN;
%token GREATERTHAN;
%token LOWEREQUAL;
%token GREATEREQUAL;
%token EQUAL;
%token DIST;
%token PRINT;
%token SCAN;
%token START;
%token FINISH;
%token END_INSTR;
%token COMMA;
%token COLON;
%token AMPERSAND;

%start comienza
%%

comienza : start code finish;

start: START {
	printf("int main(){");
};

finish: FINISH{
	printf("}");
}

code : instruction code | control_sequence code | /*empty*/;

instruction : declaration assign end_instr 
| declaration assign_string end_instr
| declaration end_instr 
| print end_instr
| in end_instr 
| var_name assign end_instr 
| var_name assign_string end_instr 
| var_name increment end_instr
| var_name decrement end_instr;

declaration: type var_name;

type: int_var | string_var | char_var | float_var;

int_var: INT_VAR{
	printf("int");
}; 

el_diego: DIEGO{
	printf("10");
}; 

string_var: STRING_VAR{
	printf("char *");
}

char_var : CHAR_VAR{
	printf("char");
}

float_var: FLOAT_VAR{
	printf("float");	
};

print: print open_parenthesis string cerrar_print | print open_parenthesis string close_parenthesis;

cerrar_print: comma string close_parenthesis
| comma var_name close_parenthesis
| comma integer close_parenthesis
| comma float close_parenthesis
| comma expression close_parenthesis
| comma string cerrar_print
| comma var_name cerrar_print
| comma integer cerrar_print
| comma expression cerrar_print
;

in: scan open_parenthesis string cerrar_in; 

cerrar_in: comma ampersand var_name close_parenthesis | comma ampersand var_name cerrar_in;

comma : COMMA {
	printf(",");     
};

ampersand: AMPERSAND{
	printf("&");
}

control_sequence : if_block | loop | switch_block;

if_block : if open_parenthesis boolean_expression close_parenthesis open_bracket code close_bracket 
| if open_parenthesis boolean_expression close_parenthesis open_bracket code close_bracket else if_block
| if open_parenthesis boolean_expression close_parenthesis open_bracket code close_bracket else open_bracket code close_bracket;

if : IF {
	printf("if");
};

open_bracket : OPEN_BRACKET {
	printf("{");
};

close_bracket : CLOSE_BRACKET {
	printf("}");
};

else : ELSE {
	printf("else");
};

loop : do open_bracket code close_bracket while open_parenthesis boolean_expression close_parenthesis end_instr 
| while open_parenthesis boolean_expression close_parenthesis open_bracket code close_bracket
| for open_parenthesis instruction boolean_expression end_instr var_name increment close_parenthesis open_bracket code close_bracket
| for open_parenthesis instruction boolean_expression end_instr var_name decrement close_parenthesis open_bracket code close_bracket;

do : DO {
	printf("do");
};

while : WHILE {
	printf("while");
};

for : FOR {
	printf("for");
};


switch_block : switch open_parenthesis var_name close_parenthesis open_bracket inside_switch close_bracket;

inside_switch : case character colon code break end_instr default_switch | case character colon code break end_instr inside_switch;

default_switch : default colon code;

switch : SWITCH {
	printf("switch");	
};

case : CASE {
	printf("case");	
};

colon : COLON {
	printf(":");     
};

default : DEFAULT {
	printf("default");	
};

break : BREAK {
	printf("break");
};


print: PRINT {
	printf("printf");
};

scan: SCAN{
	printf("scanf");
}

increment: INCREMENT {
	printf("++");
};

decrement: DECREMENT {
	printf("--");
};

var_name : VAR_NAME {
	printf("%s",$1);	 
}

string: STRING{
	printf("%s",$1); 
};

character : CHARACTER{
	printf("%s", $1);
};

assign: assignation expression;

assign_string: assignation string;

assignation: ASSIGNATION {
	printf("=");
}

boolean_expression: boolean_expression or boolean_term
					| boolean_term;

boolean_term: boolean_term and boolean_factor
			| boolean_factor;

boolean_factor: open_parenthesis boolean_expression close_parenthesis 
				| negativ boolean_factor
				| boolean;

boolean: true 
		| false 
		| comparation;

true: TRUE{
	printf("1");
}		
false: FALSE{
	printf("0");
}		

comparation: expression compare_operator expression;

expression: open_parenthesis expression add term close_parenthesis
			| open_parenthesis expression sub term close_parenthesis
			| term
			| expression add term 
			| expression sub term
			| expression modulo term;


term: open_parenthesis term multiply factor close_parenthesis
			| open_parenthesis term div factor close_parenthesis
			| term factor 
			| factor
			| term multiply factor 
			| term div factor
            | el_diego;

factor: var_name | integer | float;

integer: INTEGER{
	printf("%d",$1);
}

float: FLOAT{
	printf("%f",$1);
}

compare_operator: lowerthan 
				| greaterthan 
				| equal 
				| dist
				| lowerequal
				| greaterequal;

or: OR {
	printf("||");
}

and: AND {
	printf("&&");
}

multiply: MULTIPLY {
	printf("*");
}

add: ADD {
	printf("+");
}

sub: SUB {
	printf("-");
}

div: DIV {
	printf("/");
}

negativ: NEGATIV {
	printf("!");
}

lowerthan: LOWERTHAN {
	printf("<");
}

greaterthan: GREATERTHAN {
	printf(">");
}

equal: EQUAL {
	printf("==");
}

dist: DIST {
	printf("!=");
}

lowerequal: LOWEREQUAL {
	printf("<=");
}

greaterequal: GREATEREQUAL {
	printf(">=");
}

modulo: MODULO {
	printf("%%");	 
}

end_instr: END_INSTR {
	printf(";");
};

open_parenthesis: OPEN_PARENTHESIS {
	printf("(");
};

close_parenthesis: CLOSE_PARENTHESIS {
	printf(")");
};

%%

int yywrap(){
	return 1;
}

int main (){
	yyparse();
}

void
yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}
