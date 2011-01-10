//
//  TestRootWindowController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class RootWindowController;

@interface TestRootWindowController : SenTestCase {
    RootWindowController *_windowController;
    NSWindow *_window;

}

@end
