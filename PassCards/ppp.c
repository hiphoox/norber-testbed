// -------------------------------------------------------------------------
//
// PPPv3 - C implementation of Steve Gibson's PPP
//
// See http://www.grc.com/ppp.htm
//
// Copyright (c) 2008 John Graham-Cumming
//
// (Released undef the BSD License)
//
// -------------------------------------------------------------------------

#include "ppp.h"

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

// Increment by one a 128-bit unsigned integer

void inc( OneTwoEight * i ) 
{
  ++i->sixtyfour.low;
  if ( i->sixtyfour.low == 0 ) {
    ++i->sixtyfour.high;
  }
}

// Divide an unsigned 128-bit integer by an unsigned integer and store
// the remainder

void divide( OneTwoEight * big, unsigned int small, unsigned int * remainder )
{
  int c = 0;
  *remainder = 0;
  int i;
	
  for ( i = 15; i >= 0; --i ) {
    int v = big->byte[i];
    v += c;
    int r = v / small;
    c = ( ( 256 * v ) - ( 256 * r * small ) );
    *remainder = c / 256;
    big->byte[i] = (Byte)r;
  }
}

// Returns a buffer of passcodes.  Passcodes are null separated with
// a double null at the end.  Caller must free the buffer.

char * RetrievePasscodes( OneTwoEight firstPasscodeNumber,
												 int passcodeCount,
												 SequenceKey * sequenceKey,
												 const char * sourceAlphabet,
												 int passcodeLength )
{
  unsigned int i;
	
  unsigned int alphabetLength = strlen( sourceAlphabet );
  char * alphabet = (char *)malloc( alphabetLength + 1 );
  strcpy( alphabet, sourceAlphabet );
	
  char * passcodeListBuffer = (char *)malloc( ( passcodeLength + 1 ) * passcodeCount /*+ 1*/ );
	
  for ( i = 0; i < alphabetLength; ++i ) {
    unsigned int j;
    for ( j = i+1; j < alphabetLength; ++j ) {
      if ( *(alphabet+i) > *(alphabet+j) ) {
				char c = alphabet[j];
				*(alphabet+j) = *(alphabet+i);
				*(alphabet+i) = c;
      }
    }
  }
	
#define KEY_BITS (int)256
  Byte key[KEYLENGTH(KEY_BITS)];
	
  for ( i = 0; i < KEYLENGTH(KEY_BITS); ++i ) {
    key[i] = sequenceKey->byte[i];
  }
	
  unsigned long rk[RKLENGTH(KEY_BITS)];
  OneTwoEight plain = firstPasscodeNumber;
  
  passcodeCount *= passcodeLength;
	
  unsigned int nrounds = rijndaelSetupEncrypt( rk, key, KEY_BITS );
  OneTwoEight cipher;
	
  unsigned int c = 0;
	
  while ( passcodeCount > 0 ) {
    rijndaelEncrypt( rk, nrounds, (Byte *)&plain.sixtyfour.low, (Byte *)&cipher );
    inc( &plain );
		
    for ( i = 0; ( i < passcodeLength  ) && ( passcodeCount > 0 ); ++i ) {
      unsigned int index;
      divide( &cipher, alphabetLength, &index );
			
      *(passcodeListBuffer+c) = alphabet[index];
      ++c;
      if ( ( ( ( i + 1 ) % passcodeLength ) == 0 ) && (passcodeCount > 1)) {
				*(passcodeListBuffer+c) = ' ';
				++c;
      }
      --passcodeCount;
    }
  }
	
  free( alphabet );
	
  return passcodeListBuffer;
}

void GenerateSequenceKeyFromString( char * string,
																	 SequenceKey * sequenceKey )
{
  sha256( (const unsigned char *)string, strlen( string ),
				 (unsigned char *)sequenceKey );
}

void GenerateRandomSequenceKey( SequenceKey * sequenceKey ) {
  struct timeval t;
  gettimeofday( &t, 0 );
	
  char t_buffer[61];
  strftime( t_buffer, 60, "%c%d%e%H%I%j%m", localtime( &t.tv_sec ) );
  
  char msecs_buffer[32];
  sprintf( msecs_buffer, "%ld", t.tv_usec );
	
  char hostname_buffer[256];
  gethostname( hostname_buffer, 255 );
	
  char pointer_buffer[16];
  sprintf( pointer_buffer, "%p", sequenceKey );
	
  char loadavg_buffer[256];
  double samples[3];
  getloadavg( samples, 3 );
  sprintf( loadavg_buffer, "%f%f%f", samples[0], samples[1], samples[2] );
	
  char buffer[1024];
  sprintf( buffer, "%s-%s-%s-%s-%s", t_buffer, msecs_buffer, hostname_buffer,
					pointer_buffer, loadavg_buffer );
	
  GenerateSequenceKeyFromString( buffer, sequenceKey );
}

int ConvertHexToKey( const char * hex, SequenceKey * key ) 
{
  int i, j;
	
  for ( i = 0, j = 0; i < 64; i += 2, ++j ) {
    char pair[3];
    sprintf( pair, "%c%c", hex[i], hex[i+1] );
    int x;
    sscanf( pair, "%x", &x );
    key->byte[j] = (Byte)x;
  }
	return 1;
}

char* PassCodes( int argc, char * argv[] )
{
  if ( argc == 1 ) {
    printf( "Error: You must provide the passphrase or sequence key as the first parameter\n" );
    printf( "ppp (<sequencekey>|<passphrase>) (<offset> (<count> (<alphabet> (<passcodelength>))))\n" );
    return "";
  }
	
  SequenceKey key;
	
  if ( strlen( argv[1] ) == 0 ) {
    printf( "Generating random sequence key\n" );
    GenerateRandomSequenceKey( &key );
  } else {
    if ( ( strlen( argv[1] ) == 64 ) && ( ConvertHexToKey( argv[1], &key ) ) ) {
      printf( "Using entered sequence key\n" );
		} else {
      printf( "Generating sequence key from passphrase\n" );
      GenerateSequenceKeyFromString( argv[1], &key );
    }
  }
	
  printf( "Sequence Key: " );
  int i;
  for ( i = 0; i < SHA256_DIGEST_SIZE; ++i ) {
    printf( "%2.2x", key.byte[i] );
  }
  printf( "\n" );
	
	char * to_free;
	
  if ( argc >= 4 ) {
    OneTwoEight firstPasscode;
    
    // Warning! This only uses the bottom 64-bits of argv[2] and hence
    // can't convert a much higher number
		
    firstPasscode.sixtyfour.low = atoi( argv[2] );
    firstPasscode.sixtyfour.high = 0;
		
    int count = atoi( argv[3] );
		
    char * pppv2_alphabet = "!#%+23456789=:?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
		
    char * alphabet = pppv2_alphabet;
		
    if ( argc >= 5 ) {
      alphabet = argv[4];
    }
    
    printf( "Using alphabet: %s\n", alphabet );
		
    int length = 4;
		
    if ( argc == 6 ) {
      length = atoi( argv[5] );
    }
		
    printf( "Passcode length: %d\n", length );
		
    char * pcl = RetrievePasscodes( firstPasscode, count, &key, alphabet, length );
		
    to_free = pcl;
		
    while ( *pcl != 0 ) {
      while ( *pcl != 0 ) {
				printf( "%c", *pcl );
				++pcl;
      }
      printf( " " );
      ++pcl;
    }
		
    //free( to_free );
		
    printf( "\n" );
  }
	
  return to_free;
}

char* PassCodesFrom( const char *secuenceKey, int offset, int count, const char *alphabet, int length)
{
	
  SequenceKey key;
  ConvertHexToKey(secuenceKey, &key);
	
  printf( "Sequence Key: " );
  int i;
  for ( i = 0; i < SHA256_DIGEST_SIZE; ++i ) {
    printf( "%2.2x", key.byte[i] );
  }
  printf( "\n" );
	  
  // Warning! This only uses the bottom 64-bits of argv[2] and hence
  // can't convert a much higher number		
  OneTwoEight firstPasscode;
  firstPasscode.sixtyfour.low = offset;
  firstPasscode.sixtyfour.high = 0;
  
  printf( "Using alphabet: %s\n", alphabet );
  printf( "Passcode length: %d\n", length );
  printf( "Count: %d\n", count );
  
  char * pcl = RetrievePasscodes( firstPasscode, count, &key, alphabet, length );
  
	char * to_free;	
  to_free = pcl;
  
  while ( *pcl != 0 ) {
    while ( *pcl != 0 ) {
      printf( "%c", *pcl );
      ++pcl;
    }
    printf( " " );
    ++pcl;
  }
  printf( "\n" );
  
  return to_free;
}

