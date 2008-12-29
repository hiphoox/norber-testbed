//
//  Wallet.m
//  PassCards
//
//  Created by Norberto Ortigoza on 26/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//

#import "Wallet.h"


@implementation Wallet

@synthesize name;
@synthesize characterSet;
@synthesize sequenceKey;
@synthesize skin;
@synthesize nextValidCard;
@synthesize passcodeLength;
@synthesize passcodeCount;

+(Wallet *) walletFromName: (NSString *)name
{
  
  Wallet *newWallet = [[Wallet alloc] init];
  [newWallet setName: name];
  [newWallet setCharacterSet: @"!#%+23456789=:?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz"];
  [newWallet setSequenceKey:@"5f4b9a6c04b8e3af74eba349bea5655b0977a96037eea8a55b3347d3900043d1"];
  [newWallet setSkin:@"frontside.png"];
  [newWallet setNextValidCard:1];
  [newWallet setPasscodeLength:4];
  
  return [newWallet autorelease]; 
}

-(Card *) getNextValidCard
{
  Card *newCard = [[Card alloc] init];
  [newCard setRows:10];
  [newCard setColumns:7];
  [newCard setCardNumber:1];
  
  SequenceKey key;
  ConvertHexToKey([[self sequenceKey] UTF8String], &key);  
  //GenerateRandomSequenceKey(&key);
  
  char *pass_codes_string = PassCodesFrom(key, 
                                  [self nextValidCard],
                                  [newCard columns] * [newCard rows],
                                  [[self characterSet] UTF8String],
                                  [self passcodeLength]);
  
	NSString *codes = [NSString stringWithCString: pass_codes_string];  
  NSArray *passCodes = [codes componentsSeparatedByString:@" "];
  
  [newCard setPassCodes:passCodes];
  free(pass_codes_string);
  
  return [newCard autorelease];
}

-(Card *) getCardWithIndex: (int) index
{
  return [self getNextValidCard];  
}

@end
