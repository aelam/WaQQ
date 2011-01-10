//
//  Signaturer.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-8.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>
#include "Base64Transcoder.h"

@interface Signaturer : NSObject {

}

+ (NSString *)signClearText:(NSString *)text withSecret:(NSString *)secret ;

@end
