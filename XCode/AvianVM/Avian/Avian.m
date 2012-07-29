//
//  Avian.m
//  Avian
//
//  Created by Daniel Parnell on 27/07/12.
//  Copyright (c) 2012 Automagic Software Pty Ltd. All rights reserved.
//

#import "Avian.h"

static JNIEnv* env = nil;
static JavaVM* vm = nil;

@implementation Avian

+ (JNIEnv*) jniEnv:(NSError**)error {
    return [Avian jniEnvWithOptions: nil andError: error];
}

+ (JNIEnv*) jniEnvWithOptions:(NSArray*)options andError:(NSError *__autoreleasing *)error {
    if(env == nil) {
        JavaVMInitArgs	vm_args;
        
        NSMutableArray* opts;
        if (options) {
            opts = [options mutableCopy];
        } else {
            opts = [NSMutableArray new];
        }
        
        NSBundle* thisBundle = [NSBundle bundleForClass: [self class]];
        NSString* classpathJarPath = [thisBundle pathForResource: @"classpath" ofType: @"jar"];
        [opts addObject: [NSString stringWithFormat: @"-Xbootclasspath:=%@", classpathJarPath]];
        
        JavaVMOption* vmOptions = malloc(sizeof(JavaVMOption)*[opts count]);
        int i=0;
        for(NSString* option in opts) {
            const char* optionValue = [option cStringUsingEncoding: NSUTF8StringEncoding];
            
            vmOptions[i].extraInfo = NULL;
            vmOptions[i].optionString = strdup(optionValue);
            i++;
        }
        
        /* JNI_VERSION_1_4 is used on Mac OS X to indicate the 1.4.x and later JVM's */
        vm_args.version	= JNI_VERSION_1_4;
        JNI_GetDefaultJavaVMInitArgs(&vm_args);
        
        vm_args.options	= vmOptions;
        vm_args.nOptions = (int)[opts count];
        vm_args.ignoreUnrecognized	= JNI_TRUE;
        
        JNIEnv *env;
        
        /* start a VM session */
        int result = JNI_CreateJavaVM(&vm, (void**)&env, &vm_args);
        if(result!=0) {
            if(error) {
                NSDictionary* info = [NSDictionary dictionaryWithObject: @"Could not start JVM" forKey: NSLocalizedDescriptionKey];
                *error = [NSError errorWithDomain: NSCocoaErrorDomain code: result userInfo: info];
            }
        }
    }
    
    return env;
}

+ (JavaVM*) vm {
    return vm;
}

@end
