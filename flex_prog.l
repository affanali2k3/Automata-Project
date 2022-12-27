
%{
	#include <stdio.h>
	#include <string.h>
int semiColons = 0;
int bracketCount = 0;
int curlyBrackets = 0;
int squareBrackets = 0;
int reservedKeyWordsCount = 0;
int variables = 0;
int operators = 0;
int headerFiles = 0;
int lineNumber = 1;
int stringCount = 0;
int arrayCount = 0;
int pointersCount = 0;
 FILE *fp;
 FILE *newFile;

%}


%%
\n {lineNumber++;}

~
["][a-zA-Z0-9!-) ]*["] {fprintf(newFile, "Line -> %d   ", lineNumber);fprintf(newFile, "Token -> %s   ",yytext);fprintf(newFile,"(String)\n"); stringCount++;}
(int|string|bool|double|float|char)[ ]+[A-Za-z][0-9A-Za-z_]+[ ]*([[0-9]+])+[ ]*(=|;) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Array)\n"); arrayCount++; reservedKeyWordsCount++;semiColons++;}
(alignas|alignof|and|and_eq|asm|atomic_cancel|atomic_commit|atomic_noexcept|auto|bitand|bitor|bool|break|case|catch|char|char16_t|char32_t|class|compl|concept|const|constexpr|const_cast|continue|co_await|co_return|co_yield|decltype|default|delete|free|double|dynamic_case|else|enum|explicit|export|extern|false|float|for|friend|goto|if|import|inline|int|long|module|mutable|namespace|new|noexcept|not|not_eq|nullptr|operator|or|or_eq|private|protected|public|registor|reinterpret_cast|requires|return|short|signed|sizeof|static|static_assert|static_cast|struct|switch|synchronized|template|this|thread_local|throw|true|try|typedef|typeid|typename|union|unsigned|using|virtual|void|volatile|wchar_t|while|xor|xor_eq)([ ]+|:) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Reserved Keyword)\n");reservedKeyWordsCount++;}
([(]|[)]) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Paranthesis)\n");bracketCount++;}
; {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Semicolom)\n");semiColons++;}
([{]|[}]) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Curly braces)\n");curlyBrackets++;}
([[]|[]]) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Square braces)\n");squareBrackets++;}
(int|double|string|float|char|bool)[ ]+[A-Za-z1-9_]+[ ]*(;|=) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(User defined variables)\n");variables++; reservedKeyWordsCount++;semiColons++;}
([+]|[-]|[*]|[/]|[%]|[+][+]|[-][-]|[<]|[>]|[<][=]|[>][=]|[=][=]|[=]|[+][=]|[-][=]|[*][=]|[/][=]|[!]|[!][=]|[&][&]|[|][|]|[<][<]|[>][>]) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Operators)\n");operators++;}
[<][A-Za-z1-9_]+[>] {}
[#](include) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Header file)\n");headerFiles++;}
(int|double|string|float|char|bool)[ ]*[*]+[A-Za-z1-9_]+[ ]*(;|=) {fprintf(newFile,"Line -> %d   ", lineNumber);fprintf(newFile,"Token -> %s   ",yytext);fprintf(newFile,"(Pointer)\n"); pointersCount++; reservedKeyWordsCount++; semiColons++;}


[a-zA-Z0-9_.,]+


%%

int yywrap(){}
int main(){


 char filename[50];
 printf("Enter the filename: \n");
 scanf("%s",filename);
 fp = fopen(filename,"r");
 newFile = fopen("tokens.txt", "w");
 yyin = fp;

yylex();
fprintf(newFile, "\nreservedKeyWordsCount   " 
      "in the given input - %d\n", reservedKeyWordsCount);
fprintf(newFile,"\nvariables " 
      "in the given input - %d\n", variables);
fprintf(newFile,"\nsemiColons " 
      "in the given input - %d\n", semiColons);
fprintf(newFile,"\noperators " 
      "in the given input - %d\n", operators);
fprintf(newFile,"\nheaderFiles " 
      "in the given input - %d\n", headerFiles);
fprintf(newFile,"\nPointers " 
      "in the given input - %d\n", pointersCount);
fprintf(newFile,"\nArrays " 
      "in the given input - %d\n", arrayCount);
fprintf(newFile,"\nString " 
      "in the given input - %d\n", stringCount);
return 0;
}
