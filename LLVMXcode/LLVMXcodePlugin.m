//
//  LLVMXcodePlugin.m
//  LLVMXcode
//
//  Created by Norberto Ortigoza on 02/08/08.
//  Copyright 2008 CrossHorizons. All rights reserved.
//

#import "LLVMXcodePlugin.h"

@implementation LLVMXcodePlugin 

id foo()
{
	NSArray *array = [[NSArray alloc] init];
	
	if ([array count] > 0)
	{
		return nil;
	}
	return [array autorelease];
}

@end
