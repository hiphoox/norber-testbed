//
//  Card.h
//  PassCards
//
//  Created by Norberto Ortigoza on 26/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject {
  NSArray *passCodes;
  NSString *nextValidCode;
  int cardNumber;
  int columns;
  int rows;
}

@property (nonatomic, retain) NSArray *passCodes;
@property (nonatomic, copy) NSString *nextValidCode;
@property (nonatomic) int cardNumber;
@property (nonatomic) int columns;
@property (nonatomic) int rows;

- (NSString *) passCodeAtRow: (int) currentRow atColumn: (int) currentColumn;

@end
