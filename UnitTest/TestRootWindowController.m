//
//  TestRootWindowController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "TestRootWindowController.h"
#import "RootWindowController.h"

@implementation TestRootWindowController

- (void)setUp{
	_windowController = [[RootWindowController alloc] init];
    _window = [_windowController window];

}

- (void)tearDown {
	[_windowController release];
    _window = nil; // owned by _windowController

}

- (void)testNibName {
    STAssertEqualObjects([_windowController windowNibName], @"MainWindow",
						 @"The nib for this window should be MainWindow.nib");
}

- (void)testWindowLoading {
    STAssertNotNil(_window,
				   @"The window should be connected to the window controller.");
}

- (void)testDoSomethingButton {
// _doSomethingButton is a private method that returns the button
// conected to the doSomethingButton outlet
//	NSButton *doSomethingButton = [_windowController _doSomethingButton];
//
//	STAssertNotNil(doSomethingButton,
//				   @"The window should have a 'Do something' button.");
//
//	STAssertEqualObjects([doSomethingButton title], @"Do Something",
//						 @"The button should be titled accordingly.");
//
//	STAssertEquals([doSomethingButton action], @selector(doSomething:),
//				   @"The button should send -doSomething: to its target.");
//
//	STAssertEquals([doSomethingButton target], _windowController,
//				   @"The button should send its action to the window controller.");
}

@end
