//
//  AvianTests.m
//  AvianTests
//
//  Created by Daniel Parnell on 27/07/12.
//  Copyright (c) 2012 Automagic Software Pty Ltd. All rights reserved.
//

#import "AvianTests.h"

@implementation AvianTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    env = [Avian jniEnvWithOptions: nil andError: nil];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testClassLoading
{
    jclass result = (*env)->FindClass(env, "java/lang/Class");

    STAssertTrue(result != NULL, @"Could not load java.lang.Class");
}

@end
