/* dada.c      The user-level interface to the Dada Engine and the pb
 *             language.
 * Author:     Andrew C. Bulhak
 * Commenced:  Sat Jul  8 00:28:13 1995
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

#ifndef PREPROCESSOR
#define PREPROCESSOR "cpp"
#endif

#ifndef PB_ENGINE
#define PB_ENGINE "pb"
#endif

#define DIE(str) { fprintf(stderr, "%s: %s\n", argv[0], str); exit(1); }

void usage(char *whoami)
{
    fprintf(stderr, "usage: %s [options] file [file ....]\n", whoami);
    exit(1);
};

main(int argc, char *argv[])
{
    int i;
    char **cppargv, **pbargv;
    int cppargc, pbargc;

    int pipefd[2];
    int cpppid, pbpid;
    
    /* prepare arguments for the preprocessor and pb engine */
    cppargv = malloc(sizeof(char *)*(argc*2+1));
    cppargv[0] = PREPROCESSOR;
    cppargc = 1;

    pbargv = malloc(sizeof(char *)*argc);
    pbargv[0] = PB_ENGINE;
    pbargc = 1;
    
    /* parse arguments */
    for(i=1; argv[i][0]=='-'; i++) {
	switch(argv[i][1]) {
	case 'D': /* preprocessor definition */
	    cppargv[cppargc++] = argv[i];
	    break;
	case 'o': /* output file */
	case 'r': /* random seed */
	case 's': /* start symbol */
	    pbargv[pbargc++] = argv[i++];
	case 'd': /* dump RTN */
	    pbargv[pbargc++] = argv[i];
	    break;
	case '-': goto endflags; /* the following data is a sequence of 
				    filenames */
	};
    };
  endflags:
    if(i>=argc) usage(argv[0]);
    for(;i<argc-1;i++) {
	cppargv[cppargc++] = "-include";
	cppargv[cppargc++] = argv[i];
    };
    cppargv[cppargc++] = argv[i];
    cppargv[cppargc++] = "-";
    cppargv[cppargc++] = NULL;

    /* execute the commands */

    if(pipe(pipefd)==-1) DIE("cannot create pipe.");

    if((pbpid = fork()) == 0) {
	close(0); dup(pipefd[0]); /* connect this process to the pipe */
	close(pipefd[0]);
	execvp(PB_ENGINE, pbargv);
/*	execvp("/bin/cat", pbargv);*/
	DIE("cannot execvp " PB_ENGINE);
    } else if (pbpid==-1)
	DIE("cannot fork.");

    if((cpppid = fork()) == 0) {
	close(1); dup(pipefd[1]); /* connect this process to the pipe */
	close(pipefd[1]);
	execvp(PREPROCESSOR, cppargv);
	/* You stay out of this; you're dead. */
	kill(pbpid, SIGHUP);
	DIE("cannot execvp " PREPROCESSOR);
    } else if (cpppid==-1) {
	kill(pbpid, SIGHUP);
	DIE("cannot fork.");
    };
    close(pipefd[0]);
    close(pipefd[1]);

    /* wait for processes to finish */
    wait(NULL);
    fprintf(stderr, "wait() returned\n");
    wait(NULL);
    exit(0);
};
