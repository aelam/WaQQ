//
//  NSString+Catalog.h
//  iPhoneOAuth
//
//  Created by Ryan W. on 10-12-29.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (test)

+ (NSString *)timeStamp;
+ (NSString *)nonce;
+ (NSString *)stringWithEscapeURIComponent:(NSString *)source;
+ (NSString*)stringWithurlEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding;
+ (NSString*)stringWithurlEncode:(NSString *)originalString; // DEFAULT NSUTF8

@end
