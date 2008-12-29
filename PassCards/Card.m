//
//  Card.m
//  PassCards
//
//  Created by Norberto Ortigoza on 26/12/08.
//  Copyright 2008 StoneFree Software. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize passCodes;
@synthesize nextValidCode;
@synthesize cardNumber;
@synthesize columns;
@synthesize rows;

- (NSString *) passCodeAtRow: (int) currentRow atColumn: (int) currentColumn
{
  if(currentRow == 0)
    return [passCodes objectAtIndex: currentColumn];
  if(currentColumn == 0)
    return [passCodes objectAtIndex: currentRow * columns];
  
  return [passCodes objectAtIndex:(currentRow * columns + currentColumn)];
}

@end
