/*
 *  ppp.h
 *  PerfectPasswords
 *
 *  Created by Norberto Ortigoza on 25/12/08.
 *  Copyright 2008 StoneFree Software. All rights reserved.
 *
 */

#include <sys/time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>

#include "rijndael.h"
#include "sha2.h"


char* PassCodes( int argc, char * argv[] );
