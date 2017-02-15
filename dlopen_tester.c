/*
 * build info: gcc -o dlopen_tester dlopen_tester.c -ldl
 */
#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>

int main(int argc, char **argv) {
    void *handle;
    double (*cosine)(double);
    char *error;

    printf("try to open: %s\n", argv[1]);

    handle = dlopen(argv[1], RTLD_LAZY);
    if (!handle) {
        fputs (dlerror(), stderr);
        exit(1);
    }

    printf("successfully!\n");

    return 1;
}
