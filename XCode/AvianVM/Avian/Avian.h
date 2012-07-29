//
//  Avian.h
//  Avian
//
//  Created by Daniel Parnell on 27/07/12.
//  Copyright (c) 2012 Automagic Software Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jni.h"

@interface Avian : NSObject

+ (JNIEnv*) jniEnv:(NSError**)error;
+ (JNIEnv*) jniEnvWithOptions:(NSArray*)options andError:(NSError**)error;
+ (JavaVM*) vm;

@end
