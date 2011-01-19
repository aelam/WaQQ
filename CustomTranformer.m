//
//  CustomTranformer.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-19.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "CustomTranformer.h"
@implementation ImageTranformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
//	RLog(@"origin Value : %@",value);
//	dispatch_queue_t current_queue = dispatch_get_current_queue();
//	dispatch_queue_t download_queue = dispatch_queue_create("com.yuxipacific.download_queu", NULL);
//	
//	dispatch_async(download_queue, ^{
		NSString *real = [NSString stringWithFormat:@"%@/40",value];
		NSURL *url = [NSURL URLWithString:real];
//		NSAssert(url,@"URL shouldn't be nil value");
		NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];	
//		
//		dispatch_async(current_queue, ^{
//			//return image;
//		});		
//	});
//	[self downloadLink:value Image:^(NSImage *image){
//		RLog();
//		return image;
//	}];
//	
//	return nil;
	return image;
	
//	return [NSURL URLWithString:[NSString stringWithFormat:@"%@/40",value]];
	
//	];
//	return [image autorelease];
}	

- (void)downloadLink:(NSString *)value Image:(void(^)(NSImage *image))MyBlock {
	RLog();
	dispatch_queue_t current_queue = dispatch_get_current_queue();
	dispatch_queue_t download_queue = dispatch_queue_create([value UTF8String], NULL);
	RLog();

	dispatch_async(download_queue, ^{
		NSString *real = [NSString stringWithFormat:@"%@/40",value];
		RLog();
		NSURL *url = [NSURL URLWithString:real];
		NSAssert(url,@"URL shouldn't be nil value");
		NSImage *image = [[NSImage alloc] initWithContentsOfURL:url];	
		RLog();

		dispatch_async(current_queue, ^{
			//return image;
			MyBlock(image);
		});		
	});
}


@end

@implementation CustomTranformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
	
	return @"WOO";
//    float fahrenheitInputValue;
//    float celsiusOutputValue;
//	
//    if (value == nil) return nil;
//	
//    // Attempt to get a reasonable value from the
//    // value object.
//    if ([value respondsToSelector: @selector(floatValue)]) {
//		// handles NSString and NSNumber
//        fahrenheitInputValue = [value floatValue];
//    } else {
//        [NSException raise: NSInternalInconsistencyException
//                    format: @"Value (%@) does not respond to -floatValue.",
//		 [value class]];
//    }
//	
//    // calculate Celsius value
//    celsiusOutputValue = (5.0/9.0)*(fahrenheitInputValue - 32.0);
//	
//    return [NSNumber numberWithFloat: celsiusOutputValue];
}

- (id)reverseTransformedValue:(id)value {
	return @"OOW";
}

@end
