//
//  Wallet.h
//  PassCards
//
//  Created by Norberto Ortigoza on 26/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "ppp.h"

@interface Wallet : NSObject {
	NSString *name;
	NSString *characterSet;
	NSString *sequenceKey;
	NSString *skin;
	int nextCard;
	int currentValidCard;
	int passcodeLength;
	int passcodeCount;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *characterSet;
@property (nonatomic, copy) NSString *sequenceKey;
@property (nonatomic, copy) NSString *skin;
@property (nonatomic) int nextCard;
@property (nonatomic) int currentValidCard;
@property (nonatomic) int passcodeLength;
@property (nonatomic) int passcodeCount;

+(Wallet *) walletFromName: (NSString *)name;

-(Card *) getCurrentValidCard;
-(Card *) getNextCard;
-(Card *) getPreviousCard;
-(Card *) getCardWithIndex: (int) index;

@end
