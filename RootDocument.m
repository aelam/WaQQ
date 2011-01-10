//
//  RootDocument.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-8.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "RootDocument.h"
#import "LOAuth.h"

@implementation RootDocument

- (id)init {
	if (self = [super init]) {
		RLog();
	}
	return self;
}


- (IBAction)login:(id)sender {
	LOAuth *oauth = [[LOAuth alloc] initWithDelegate:self];
	//[oauth showOAuthPage];
	[oauth startRequestToken];
//	NSOpenPanel *aPanel = [[NSOpenPanel alloc] initWithContentRect:CGRectMake(0, 0, 400, 400) styleMask:1 backing:NSBackingStoreBuffered defer:YES];
//	[aPanel beginSheetForDirectory:@"/" file:@"Developers" types:nil modalForWindow:nil modalDelegate:nil didEndSelector:nil contextInfo:nil];
}



- (NSString *)windowNibName {
    // Implement this to return a nib to load OR implement -makeWindowControllers to manually create your controllers.
    return @"RootDocument";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    return YES;
}

@end
