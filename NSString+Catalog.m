//
//  NSString+Catalog.m
//  iPhoneOAuth
//

#import "NSString+Catalog.h"
#import <CommonCrypto/CommonHMAC.h>
#include "Base64Transcoder.h"

#define SPECIAL_CHARACTER @"!*'();:@&=+$,/?%#[]"

@implementation NSString(test)

+ (NSString *)timeStamp {
	return [NSString stringWithFormat:@"%d",time(NULL)];
}

+ (NSString *)nonce {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
//	return [(NSString *)string autorelease];
	NSString *subString = [(NSString *)string substringToIndex:20];
//	RLog(@"nonce :%d",[(NSString *)subString length]);
	[(NSString *)string autorelease];
	return subString;
	
}

+ (NSString *)stringWithEscapeURIComponent:(NSString *)source {
	if (source == nil || source.length == 0) return nil;
	NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
																				  (CFStringRef)source, 
																				  NULL,
																				  (CFStringRef)SPECIAL_CHARACTER,
																				  kCFStringEncodingUTF8);
	return [encodedString autorelease];
}

+ (NSString*)stringWithurlEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects://@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" ,
							//@"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
	
    NSArray *replaceChars = [NSArray arrayWithObjects://@"%3B" , @"%2F" , @"%3F" , @"%3A" , 
                             @"%40" , @"%26" , 
							 //@"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
	
    int len = [escapeChars count];
	
    NSString *temp = [originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding];
	
    int i;
    for(i = 0; i < len; i++)
    {
        temp = [temp stringByReplacingOccurrencesOfString:[escapeChars objectAtIndex:i]
                                               withString:[replaceChars objectAtIndex:i]
                                                  options:NSLiteralSearch
                                                    range:NSMakeRange(0, [temp length])];
    }
	
    NSString *_out = [NSString stringWithString: temp];
	
    return _out;
}

// DEFAULT NSUTF8
+ (NSString*)stringWithurlEncode:(NSString *)originalString {
	return [self stringWithurlEncode:originalString stringEncoding:NSUTF8StringEncoding];
}
/*
NSString *hmac_sha1(NSString *key,NSString *text){
//+ (NSString *)hmac_sha1(NSString *key,NSString *text) {
	
	const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
	
	char cHMAC[CC_SHA1_DIGEST_LENGTH];
	
	CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
	
	NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [Base64 stringByEncodingData:HMAC];
	[HMAC release];
	return hash;
}
*/
+ (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret 
{
	NSLog(@"[LINE:%d] text %@, secret :%@",__LINE__,text,secret);
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
