//
//  NSObject+Category.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "NSObject+Collection.h"


@implementation NSObject (Collection)

- (BOOL)isNSArray {
	if ([[[self class]description] rangeOfString:@"Array"].location != NSNotFound) {
		return YES;
	}
	return NO;
}

- (BOOL)isNSDictionary {
	if ([[[self class]description] rangeOfString:@"Dictionary"].location != NSNotFound) {
		return YES;
	}
	return NO;
}

@end
