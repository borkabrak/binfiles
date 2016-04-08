#include <stdio.h>
#include <readline/readline.h>

int main() {
    char* line;
    line = readline();
    printf("Line:%s", line);
}
