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

#pragma pack(push,1)

typedef unsigned char Byte;
typedef unsigned long long SixtyFour;

typedef union __OneTwoEight {
  struct {
    SixtyFour low;
    SixtyFour high;
  } sixtyfour;
  Byte byte[16];
} OneTwoEight;

typedef struct __SequenceKey {
  Byte byte[SHA256_DIGEST_SIZE];
} SequenceKey;

#pragma pack(pop)

char* PassCodesFrom( SequenceKey sequenceKey, int offset, int count, const char *alphabet, int length);
void GenerateRandomSequenceKey( SequenceKey *sequenceKey );
int ConvertHexToKey( const char *hex, SequenceKey *sequenceKey );
char* ConvertKeyToHex(SequenceKey sequenceKey);
