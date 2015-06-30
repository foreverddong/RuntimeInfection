//
//  main.m
//  RuntimeInfection
//
//  Created by Brian Hsu on 15/6/29.
//  Copyright (c) 2015年 Brian Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "myObject.h"
#import "RIInjection.h"
int main(int argc, const char * argv[]) {

    myObject *testObject = [[myObject alloc] init];
    
    myObject *targetObject = [[myObject alloc] init];
        RIInjection *testInjection = [[RIInjection alloc] initWithInjectionHostClassName:@"myObject"];
    //[testInjection setInjectionHostWithString:@"myObject"];
    [testInjection hijackMethod:@selector(testFunction2withString:) WithObject:targetObject selector:@selector(replacedFunction:) overrideArgumentType:NO];
    [testInjection restoreMethod];
    [testInjection hijackMethod:@selector(testFunction2withString:) WithObject:targetObject selector:@selector(replacedFunction:) overrideArgumentType:NO];
    
    [testObject testFunction2withString:@"meow"];


    return 0;
}

