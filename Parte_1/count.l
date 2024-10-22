%{
    int num_lines = 0;
    int num_chars = 0;
%}

%%
\n      ++num_lines; ++num_chars;
.       ++num_chars;
%%

int main() {
    yylex();
    printf("\nResultados:\n");
    printf("Número de líneas: %d\n", num_lines);
    printf("Número de caracteres: %d\n", num_chars);
    return 0;
}
