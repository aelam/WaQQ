//
//  Signaturer.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-8.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "Signaturer.h"


@implementation Signaturer

+ (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret 
{
//	NSLog(@"[LINE:%d] text %@, secret :%@",__LINE__,text,secret);
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
	CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    
    //Base64 Encoding
    
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    
    return [base64EncodedResult autorelease];
}
@end
