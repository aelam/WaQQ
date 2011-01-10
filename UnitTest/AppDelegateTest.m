//
//  AppDelegateTest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//
//  Link to Google Toolbox For Mac (IPhone Unit Test): 
//					http://code.google.com/p/google-toolbox-for-mac/wiki/iPhoneUnitTesting
//  Link to OCUnit:	http://www.sente.ch/s/?p=276&lang=en
//  Link to OCMock:	http://www.mulle-kybernetik.com/software/OCMock/



//#import <UIKit/UIKit.h>
//#import <OCMock/OCMock.h>
//#import <OCMock/OCMConstraint.h>
//#import "GTMSenTestCase.h"
////#import "application_headers" as required

#import <GHUnit/GHUnit.h>

@interface AppDelegateTest : GHTestCase {
	id mock; // Mock object used in tests	
}
@end

@implementation AppDelegateTest


- (void) setUp {

}

// Start all test methods with testXXX
- (void) testMath {
    GHAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
}

- (void) testRaisesExceptionWhenWrongMethodIsCalled {
//	[[mock stub] lowercaseString]; // Telling the mock object about a method
	GHAssertTrue([mock uppercaseString], @"Should have raised an exception.");	
}

- (void) tearDown {
    // Release data structures here.
}


@end
