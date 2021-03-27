// A C program to demonstrate buffer overflow #include <stdio.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
  // Reserve 5 byte of buffer plus the terminating NULL. // should allocate 8
  // bytes = 2 double words, To overflow, need more than 8 bytes...
  // char buffer[5] = {'A', 'B', 'C', 'D', '\0'}; // If more than 8 characters
  // input
  char buffer[__TRY_BUFFER_SIZE__];
  // by user, there will be access
  // violation, segmentation fault
  // a prompt how to execute the program...
  if (argc < 2) {
    printf("strcpy() NOT executed....\n");
    printf("Syntax: %s <characters>\n", argv[0]);
    exit(2);
  }
  printf("trying to get length of strings . . \n");
  int len_src = strlen(argv[1]);
  int len_dst = strlen(buffer);
  printf("length of string input  : %d\n", len_src);
  printf("length of string buffer : %d\n", len_dst);
  // copy the user input to mybuffer, without any
  // bound checking a secure version is srtcpy_s()
  strcpy(buffer, argv[1]);
  printf("buffer content= %s\n", buffer);
  // you may want to try strcpy_s()
  printf("strcpy() executed...\n");
  return 0;
}
