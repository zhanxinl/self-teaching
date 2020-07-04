#include <stdio.h>
#include <string.h>

#include <unistd.h>
#include <sys/stat.h>

#include "beargit.h"
#include "util.h"

/* Implementation Notes:
 *
 * - Functions return 0 if successful, 1 if there is an error.
 * - All error conditions in the function description need to be implemented
 *   and written to stderr. We catch some additional errors for you in main.c.
 * - Output to stdout needs to be exactly as specified in the function description.
 * - Only edit this file (beargit.c)
 * - You are given the following helper functions:
 *   * fs_mkdir( dirname): create directory <dirname>
 *   * fs_rm(filename): delete file <filename>
 *   * fs_mv(src,dst): move file <src> to <dst>, overwriting <dst> if it exists
 *   * fs_cp(src,dst): copy file <src> to <dst>, overwriting <dst> if it exists
 *   * write_string_to_file(filename,str): write <str> to filename (overwriting contents)
 *   * read_string_from_file(filename,str,size): read a string of at most <size> (incl.
 *     NULL character) from file <filename> and store it into <str>. Note that <str>
 *     needs to be large enough to hold that string.
 *  - You NEED to test your code. The autograder we provide does not contain the
 *    full set of tests that we will run on your code. See "Step 5" in the homework spec.
 */

/* beargit init
 *
 * - Create .beargit directory
 * - Create empty .beargit/.index file
 * - Create .beargit/.prev file containing 0..0 commit id
 *
 * Output (to stdout):
 * - None if successful
 */

int beargit_init(void) {
  fs_mkdir(".beargit");

  FILE* findex = fopen(".beargit/.index", "w");
  fclose(findex);
  
  write_string_to_file(".beargit/.prev", "0000000000000000000000000000000000000000");

  return 0;
}


/* beargit add <filename>
 * 
 * - Append filename to list in .beargit/.index if it isn't in there yet
 *
 * Possible errors (to stderr):
 * >> ERROR: File <filename> already added
 *
 * Output (to stdout):
 * - None if successful
 */

int beargit_add(const char* filename) {
  FILE* findex = fopen(".beargit/.index", "r");
  FILE* fnewindex = fopen(".beargit/.newindex", "w");

  char line[FILENAME_SIZE];
  while(fgets(line, sizeof(line), findex)) {
    strtok(line, "\n");
    if (strcmp(line, filename) == 0) {
      fprintf(stderr, "ERROR: File %s already added\n", filename);
      fclose(findex);
      fclose(fnewindex);
      fs_rm(".beargit/.newindex");
      return 3;
    }

    fprintf(fnewindex, "%s\n", line);
  }

  fprintf(fnewindex, "%s\n", filename);
  fclose(findex);
  fclose(fnewindex);

  fs_mv(".beargit/.newindex", ".beargit/.index");

  return 0;
}


/* beargit rm <filename>
 * 
 * See "Step 2" in the homework 1 spec.
 *
 */

int beargit_rm(const char* filename) {
  /* COMPLETE THE REST */
  FILE* findex = fopen(".beargit/.index", "r");
  FILE *fnewindex = fopen(".beargit/.newindex", "w");

 char line[FILENAME_SIZE];
 int remove=0;
  while(fgets(line, sizeof(line), findex)) {
    strtok(line, "\n");
    if (strcmp(line, filename) == 0) {
      remove=1;
      continue;
    }
    fprintf(fnewindex, "%s\n", line);
  }

  fclose(findex);
  fclose(fnewindex);
  if (remove==0){
    fprintf(stderr, "ERROR: File %s `not tracked \n", filename);
    fs_rm(".beargit/.newindex");
      return 1;
  }

  fs_mv(".beargit/.newindex", ".beargit/.index");
  return 0;
}


/* beargit commit -m <msg>
 *
 * See "Step 3" in the homework 1 spec.
 *
 */

const char* go_bears = "GO BEARS!";

int is_commit_msg_ok(const char* msg) {
  /* COMPLETE THE REST */
int i=0;
int j=0;

while (msg[i]!='\0'){
while (msg[i]==go_bears[j]){
  j++;
  i++;
}
if (j==strlen(go_bears)-1){
  return 1;
}
i++; 
j=0;
}
return 0;
}

void next_commit_id(char* commit_id) {
  /* COMPLETE THE REST */
  int i=0;
  int change=0;
  while (commit_id[i]!='\0'){
    switch (commit_id[i])
    {
    case '0':
    case 'c':
    commit_id[i]='6';
    change=1;
      break;
    case '6':
    commit_id[i]='1';
    change=1;
    break;
    case '1':
    commit_id[i]='c';
    change=1;
    break;
    default:
    fprintf(stderr, "ERROR: commit id can only contain '1', '6' and 'c',  the id is \"%s\"\n", commit_id);
    break;
    }
    if (change==1){
      return;
    }
    i++; 
  }
if (change==0){
  fprintf(stderr, "ERROR: the comment_id fails to change");
}
}

int beargit_commit(const char* msg) {
  if (!is_commit_msg_ok(msg)) {
    fprintf(stderr, "ERROR: Message must contain \"%s\"\n", go_bears);
    return 1;
  }

  char commit_id[COMMIT_ID_SIZE];
  char commit_dir[FILENAME_SIZE];
  char commit_file[FILENAME_SIZE];

  FILE* findex = fopen(".beargit/.index", "r");
  char new_line[FILENAME_SIZE];
  char line[FILENAME_SIZE];
  read_string_from_file(".beargit/.prev", commit_id, COMMIT_ID_SIZE);
  next_commit_id(commit_id);

  /* COMPLETE THE REST */
  /*a new directory .beargit/<newid>*/
  sprintf(commit_dir, ".beargit/%s", commit_id);
  fs_mkdir(commit_dir);

  sprintf(commit_file, "%s/.index", commit_dir);
  fs_cp(".beargit/.index",commit_file);

  sprintf(commit_file, "%s/.prev", commit_dir);
  fs_cp(".beargit/.prev",commit_file);

  while(fgets(line, sizeof(line), findex)){
    strtok(line, "\n");
    sprintf(new_line,"./%s", line);
    sprintf(commit_file, "%s/%s",commit_dir, line);
    fs_cp(new_line,commit_file);
  }

  fclose(findex);
  sprintf(commit_file, "%s/.msg", commit_dir);
  write_string_to_file(commit_file,msg);
  write_string_to_file(".beargit/.prev", commit_id);
  return 0;
}

/* beargit status
 *
 * See "Step 1" in the homework 1 spec.
 *
 */

int beargit_status() {
  /* COMPLETE THE REST */
  FILE* findex = fopen(".beargit/.index", "r");
  char line[FILENAME_SIZE];
  int size;

  fprintf(stdout, "Tracked files: \n");

  while(fgets(line, sizeof(line), findex)) {
    strtok(line, "\n");
    fprintf(stdout, "%s\n", line);
    size++;
  }

 fclose(findex);

  fprintf(stdout,"\n %d files total \n",size);

  return 0;
}


void beargit_idmsg_read(char* id){
  
  if (strcmp(id,"0000000000000000000000000000000000000000")==0){
    return;
    }
    
    char commit_dir[FILENAME_SIZE];
    char commit_file[FILENAME_SIZE];
    char msg[MSG_SIZE];

   sprintf(commit_dir, ".beargit/%s", id);
   sprintf(commit_file, "%s/.msg", commit_dir);
   read_string_from_file(commit_file,msg, MSG_SIZE);

   fprintf(stdout, "\n commit \t %s \n %s", id, msg);

   sprintf(commit_file, "%s/.prev", commit_dir);
   read_string_from_file(commit_file, id, COMMIT_ID_SIZE);
   beargit_idmsg_read(id);
}

/* beargit log
 *
 * See "Step 4" in the homework 1 spec.
 *
 */

int beargit_log() {
  /* COMPLETE THE REST */
  char commit_id[COMMIT_ID_SIZE];

  read_string_from_file(".beargit/.prev", commit_id, COMMIT_ID_SIZE);

  if (strcmp(commit_id,"0000000000000000000000000000000000000000")==0){
    fprintf(stderr, "ERROR: There are no commits!");
    return 1;
  }

beargit_idmsg_read(commit_id);

  return 0;
}


